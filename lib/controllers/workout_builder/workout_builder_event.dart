import 'package:flutter/material.dart';
import 'package:notoro/models/workout/exercise_model.dart';

abstract class WorkoutBuilderEvent {}

class LoadAvailableExercises extends WorkoutBuilderEvent {
  final BuildContext context;
  LoadAvailableExercises(this.context);
}

class AddExerciseToWorkout extends WorkoutBuilderEvent {
  final ExerciseModel exercise;
  final BuildContext context;
  AddExerciseToWorkout(this.exercise, this.context);
}

class RemoveExerciseFromWorkout extends WorkoutBuilderEvent {
  final int index;
  RemoveExerciseFromWorkout(this.index);
}

class UpdateExerciseSet extends WorkoutBuilderEvent {
  final int exerciseIndex;
  final int setIndex;
  final int newReps;
  final double newWeight;

  UpdateExerciseSet({
    required this.exerciseIndex,
    required this.setIndex,
    required this.newReps,
    required this.newWeight,
  });
}

class ReorderExercise extends WorkoutBuilderEvent {
  final int oldIndex;
  final int newIndex;
  ReorderExercise(this.oldIndex, this.newIndex);
}

class UpdateFullExercise extends WorkoutBuilderEvent {
  final int exerciseIndex;
  final int newSets;
  final List<int> newReps;
  final List<double> newWeight;

  UpdateFullExercise({
    required this.exerciseIndex,
    required this.newSets,
    required this.newReps,
    required this.newWeight,
  });
}

class UpdateWorkoutName extends WorkoutBuilderEvent {
  final String name;
  UpdateWorkoutName(this.name);
}

class AddAvailableExercise extends WorkoutBuilderEvent {
  final ExerciseModel exercise;
  AddAvailableExercise(this.exercise);
}

class RemoveAvailableExercise extends WorkoutBuilderEvent {
  final ExerciseModel exercise;

  RemoveAvailableExercise(this.exercise);
}
