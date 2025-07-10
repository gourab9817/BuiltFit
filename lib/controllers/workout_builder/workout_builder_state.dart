import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

class WorkoutBuilderState {
  final List<ExerciseModel> availableExercises;
  final List<ExerciseTrainingModel> selectedExercises;
  final String workoutName;

  WorkoutBuilderState({
    required this.availableExercises,
    required this.selectedExercises,
    required this.workoutName,
  });

  WorkoutBuilderState copyWith({
    List<ExerciseModel>? availableExercises,
    List<ExerciseTrainingModel>? selectedExercises,
    String? workoutName,
  }) {
    return WorkoutBuilderState(
      availableExercises: availableExercises ?? this.availableExercises,
      selectedExercises: selectedExercises ?? this.selectedExercises,
      workoutName: workoutName ?? this.workoutName,
    );
  }
}
