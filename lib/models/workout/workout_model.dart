import 'package:hive/hive.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 3)
class WorkoutModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<ExerciseTrainingModel> exercises;

  WorkoutModel({
    required this.name,
    required this.exercises,
  });

  WorkoutModel copyWith({
    String? name,
    List<ExerciseTrainingModel>? exercises,
  }) {
    return WorkoutModel(
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }
}
