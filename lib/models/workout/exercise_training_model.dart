import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/models/workout/body_part.dart';

part 'exercise_training_model.g.dart';

@HiveType(typeId: 1)
class ExerciseTrainingModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<BodyPart> bodyParts;

  @HiveField(2)
  final String assetImagePath;

  @HiveField(3)
  final int sets;

  @HiveField(4)
  final List<int> reps;

  @HiveField(5)
  final List<double> weight;

  ExerciseTrainingModel({
    required this.name,
    required this.bodyParts,
    required this.assetImagePath,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  ExerciseTrainingModel copyWith({
    String? name,
    List<BodyPart>? bodyParts,
    String? assetImagePath,
    int? sets,
    List<int>? reps,
    List<double>? weight,
  }) {
    return ExerciseTrainingModel(
      name: name ?? this.name,
      bodyParts: bodyParts ?? this.bodyParts,
      assetImagePath: assetImagePath ?? this.assetImagePath,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
    );
  }
}
