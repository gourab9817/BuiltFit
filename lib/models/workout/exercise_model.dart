import 'package:notoro/models/workout/body_part.dart';

import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 4)
class ExerciseModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<BodyPart> bodyParts;

  @HiveField(2)
  final String assetImagePath;

  @HiveField(3)
  final bool isCustom;

  ExerciseModel({
    required this.name,
    required this.bodyParts,
    required this.assetImagePath,
    this.isCustom = false,
  });
}
