import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

abstract class WorkoutDetailEvent extends Equatable {
  const WorkoutDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkoutDetail extends WorkoutDetailEvent {
  final int workoutKey;

  const LoadWorkoutDetail(this.workoutKey);

  @override
  List<Object?> get props => [workoutKey];
}

class RemoveExerciseFromDetailWorkout extends WorkoutDetailEvent {
  final int index;

  const RemoveExerciseFromDetailWorkout(this.index);
}

class ReorderExerciseInDetail extends WorkoutDetailEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderExerciseInDetail(this.oldIndex, this.newIndex);
}

class AddSetToExerciseFromDetail extends WorkoutDetailEvent {
  final int exerciseIndex;
  final BuildContext context;

  const AddSetToExerciseFromDetail(this.exerciseIndex, this.context);
}

class UpdateExerciseSetFromDetail extends WorkoutDetailEvent {
  final int exerciseIndex;
  final int setIndex;
  final int reps;
  final double weight;

  const UpdateExerciseSetFromDetail({
    required this.exerciseIndex,
    required this.setIndex,
    required this.reps,
    required this.weight,
  });
}

class RemoveSetFromExerciseFromDetail extends WorkoutDetailEvent {
  final int exerciseIndex;
  final int setIndex;

  const RemoveSetFromExerciseFromDetail({
    required this.exerciseIndex,
    required this.setIndex,
  });

  @override
  List<Object?> get props => [exerciseIndex, setIndex];
}

class AddExerciseToWorkoutDetails extends WorkoutDetailEvent {
  final ExerciseTrainingModel exercise;

  const AddExerciseToWorkoutDetails(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

class LoadAvailableExercisesDetails extends WorkoutDetailEvent {
  final BuildContext context;

  const LoadAvailableExercisesDetails(this.context);
}
