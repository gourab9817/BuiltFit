import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:notoro/models/workout/workout_model.dart';

class WorkoutSessionController extends ChangeNotifier {
  final WorkoutModel workout;
  final Map<int, int> restBetweenSets;
  final Map<int, int> restAfterExercises;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _restTimer;
  Timer? _tickTimer;

  int currentExercise = 0;
  int currentSet = 0;
  Duration restRemaining = Duration.zero;
  bool isResting = false;

  late List<ExerciseTrainingModel> updatedExercises;

  bool get hasNextExercise => currentExercise < workout.exercises.length - 1;

  String get nextExerciseName =>
      hasNextExercise ? workout.exercises[currentExercise + 1].name : '';

  bool _isPaused = false;
  bool get isPaused => _isPaused;

  final Map<int, List<Duration>> _setDurations = {};
  DateTime? _setStartTime;
  Map<int, List<Duration>> get setDurations => _setDurations;
  int? interruptedExerciseIndex;
  int? interruptedSetIndex;

  bool _isLastSetExercise = false;
  bool get isLastSetExercise => _isLastSetExercise;

  bool _isLastSetOfLastExerciseStarted = false;
  bool get isLastSetOfLastExerciseStarted => _isLastSetOfLastExerciseStarted;
  bool get isLastSet => currentSet == currentExerciseModel.sets - 1;
  bool get isLastExercise => currentExercise == updatedExercises.length - 1;

  WorkoutSessionController({
    required this.workout,
    required this.restBetweenSets,
    required this.restAfterExercises,
  }) {
    updatedExercises = workout.exercises
        .map((e) => ExerciseTrainingModel(
              name: e.name,
              bodyParts: e.bodyParts,
              assetImagePath: e.assetImagePath,
              sets: e.sets,
              reps: List.from(e.reps),
              weight: List.from(e.weight),
            ))
        .toList();

    _stopwatch.start();
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });

    _setStartTime = DateTime.now();

    notifyListeners();
  }

  Duration get elapsed => _stopwatch.elapsed;

  Map<String, dynamic> get interruptionPoint => {
        'exerciseIndex': interruptedExerciseIndex,
        'setIndex': interruptedSetIndex,
      };

  ExerciseTrainingModel get currentExerciseModel =>
      updatedExercises[currentExercise];

  void abandon() {
    interruptedExerciseIndex = currentExercise;
    interruptedSetIndex = currentSet;

    notifyListeners();
  }

  void pauseWorkout() {
    _isPaused = true;
    _stopwatch.stop();
    _tickTimer?.cancel();
    _restTimer?.cancel();
    notifyListeners();
  }

  void resumeWorkout() {
    _isPaused = false;
    _stopwatch.start();
    _startTickTimer();
    if (isResting) {
      _startRestTimer();
    }
    notifyListeners();
  }

  void _startTickTimer() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  void _startRestTimer() {
    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      restRemaining -= const Duration(seconds: 1);
      if (restRemaining.inSeconds <= 0) {
        timer.cancel();
        isResting = false;
      }
      notifyListeners();
    });
  }

  void finishSet() {
    if (_setStartTime != null) {
      final duration = DateTime.now().difference(_setStartTime!);
      _setDurations.putIfAbsent(currentExercise, () => []);
      _setDurations[currentExercise]!.add(duration);
    }

    _isLastSetExercise = currentSet == currentExerciseModel.sets - 1;

    if (isLastSet && isLastExercise) {
      _isLastSetOfLastExerciseStarted = true;
    }
    if (currentSet < currentExerciseModel.sets - 1) {
      currentSet++;
      _startRest(restBetweenSets[currentExercise] ?? 60);
    } else if (currentExercise < updatedExercises.length - 1) {
      currentExercise++;
      currentSet = 0;
      _startRest(restAfterExercises[currentExercise - 1] ?? 90);
    } else {
      _stopwatch.stop();
      _setStartTime = null;
      notifyListeners();
    }
  }

  void _startRest(int seconds) {
    restRemaining = Duration(seconds: seconds);
    isResting = true;
    notifyListeners();

    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      restRemaining -= const Duration(seconds: 1);
      if (restRemaining.inSeconds <= 0) {
        timer.cancel();
        isResting = false;
        _setStartTime = DateTime.now();
      }
      notifyListeners();
    });
  }

  HistoryModel saveToHistory({required bool isAbandoned}) {
    final history = HistoryModel(
      workoutName: workout.name,
      exercises: updatedExercises,
      date: DateTime.now(),
      duration: _stopwatch.elapsed,
      wasAbandoned: isAbandoned,
      interruptedExerciseIndex: interruptedExerciseIndex,
      interruptedSetIndex: interruptedSetIndex,
      setDurations: _setDurations,
    );

    Hive.box<HistoryModel>('workout_history').add(history);
    return history;
  }

  void add15sRest() {
    restRemaining += const Duration(seconds: 15);
    notifyListeners();
  }

  void editSet(int setIndex, int newReps, double newWeight) {
    currentExerciseModel.reps[setIndex] = newReps;
    currentExerciseModel.weight[setIndex] = newWeight;
    notifyListeners();
  }

  bool get isFinished =>
      isLastExercise &&
      isLastSet &&
      !isResting &&
      _isLastSetOfLastExerciseStarted;

  @override
  void dispose() {
    _restTimer?.cancel();
    _tickTimer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
