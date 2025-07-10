import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/data/exercise_factory.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

import '../settings/settings_notifier.dart';

class WorkoutBuilderBloc
    extends Bloc<WorkoutBuilderEvent, WorkoutBuilderState> {
  WorkoutBuilderBloc()
      : super(WorkoutBuilderState(
            availableExercises: [], selectedExercises: [], workoutName: '')) {
    on<LoadAvailableExercises>(onLoadAvailableExercises);
    on<AddExerciseToWorkout>(onAddExercise);
    on<RemoveExerciseFromWorkout>(onRemoveExercise);
    on<UpdateExerciseSet>(onUpdateExerciseSet);
    on<ReorderExercise>(onReorderExercise);
    on<UpdateFullExercise>(onUpdateFullExercise);
    on<UpdateWorkoutName>((event, emit) {
      emit(state.copyWith(workoutName: event.name));
    });
    on<AddAvailableExercise>(onAddAvailableExercise);
    on<RemoveAvailableExercise>(onRemoveAvailableExercise);
  }

  void onLoadAvailableExercises(
    LoadAvailableExercises event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    final baseExercises = ExerciseFactory.getBaseExercises(event.context);

    final customBox = await Hive.openBox<ExerciseModel>('custom_exercises');
    final customExercises = customBox.values.toList();

    final all = [...baseExercises, ...customExercises];

    emit(state.copyWith(availableExercises: all));
  }

  void onAddExercise(
    AddExerciseToWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final settings = event.context.read<SettingsNotifier>().settings;
    final newList = List<ExerciseTrainingModel>.from(state.selectedExercises)
      ..add(ExerciseTrainingModel(
        assetImagePath: event.exercise.assetImagePath,
        name: event.exercise.name,
        bodyParts: event.exercise.bodyParts,
        sets: settings.defaultSets,
        reps: List.filled(settings.defaultSets, settings.defaultReps),
        weight: List.filled(settings.defaultSets, 0),
      ));

    emit(state.copyWith(selectedExercises: newList));
  }

  void onRemoveExercise(
    RemoveExerciseFromWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final newList = List<ExerciseTrainingModel>.from(state.selectedExercises)
      ..removeAt(event.index);

    emit(state.copyWith(selectedExercises: newList));
  }

  void onUpdateExerciseSet(
    UpdateExerciseSet event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final list = List<ExerciseTrainingModel>.from(state.selectedExercises);
    final current = list[event.exerciseIndex];

    if (event.setIndex < 0 || event.setIndex >= current.sets) return;

    final updatedReps = List<int>.from(current.reps);
    final updatedWeight = List<double>.from(current.weight);

    updatedReps[event.setIndex] = event.newReps;
    updatedWeight[event.setIndex] = event.newWeight;

    final updatedExercise = ExerciseTrainingModel(
      assetImagePath: current.assetImagePath,
      name: current.name,
      bodyParts: current.bodyParts,
      sets: current.sets,
      reps: updatedReps,
      weight: updatedWeight,
    );

    list[event.exerciseIndex] = updatedExercise;

    emit(state.copyWith(selectedExercises: list));
  }

  void onReorderExercise(
    ReorderExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final list = List<ExerciseTrainingModel>.from(state.selectedExercises);

    if (event.oldIndex < 0 || event.oldIndex >= list.length) return;
    if (event.newIndex < 0 || event.newIndex >= list.length) return;
    final item = list.removeAt(event.oldIndex);
    list.insert(event.newIndex, item);

    emit(state.copyWith(selectedExercises: list));
  }

  void onUpdateFullExercise(
    UpdateFullExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final list = List<ExerciseTrainingModel>.from(state.selectedExercises);

    if (event.exerciseIndex < 0 || event.exerciseIndex >= list.length) return;

    final current = list[event.exerciseIndex];

    final updatedExercise = ExerciseTrainingModel(
      assetImagePath: current.assetImagePath,
      name: current.name,
      bodyParts: current.bodyParts,
      sets: event.newSets,
      reps: event.newReps,
      weight: event.newWeight,
    );

    list[event.exerciseIndex] = updatedExercise;

    emit(state.copyWith(selectedExercises: list));
  }

  void onAddAvailableExercise(
    AddAvailableExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    final updatedList = List<ExerciseModel>.from(state.availableExercises)
      ..add(event.exercise);

    emit(state.copyWith(availableExercises: updatedList));

    final customBox = await Hive.openBox<ExerciseModel>('custom_exercises');
    await customBox.add(event.exercise);
  }

  void onRemoveAvailableExercise(
    RemoveAvailableExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) async {
    final updatedList = List<ExerciseModel>.from(state.availableExercises)
      ..removeWhere((e) => e.name == event.exercise.name);

    emit(state.copyWith(availableExercises: updatedList));

    final customBox = await Hive.openBox<ExerciseModel>('custom_exercises');

    final keyToRemove = customBox.keys.firstWhere(
      (key) => customBox.get(key)?.name == event.exercise.name,
      orElse: () => null,
    );

    if (keyToRemove != null) {
      await customBox.delete(keyToRemove);
    }
  }
}
