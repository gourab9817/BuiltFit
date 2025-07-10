import 'package:equatable/equatable.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

import '../../models/workout/workout_model.dart';

class WorkoutDetailState extends Equatable {
  final List<ExerciseTrainingModel>? exercises;
  final WorkoutModel? workout;
  final List<ExerciseModel> availableExercises;

  const WorkoutDetailState({
    required this.workout,
    required this.exercises,
    required this.availableExercises,
  });

  WorkoutDetailState copyWith({
    WorkoutModel? workout,
    List<ExerciseTrainingModel>? exercises,
    List<ExerciseModel>? availableExercises,
  }) {
    return WorkoutDetailState(
      workout: workout ?? this.workout,
      exercises: exercises ?? this.exercises,
      availableExercises: availableExercises ?? this.availableExercises,
    );
  }

  @override
  List<Object?> get props => [
        workout,
        exercises,
        availableExercises,
      ];
}
