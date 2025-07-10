import 'package:hive_flutter/hive_flutter.dart';

part 'body_part.g.dart';

@HiveType(typeId: 2)
enum BodyPart {
  @HiveField(0)
  chest,
  @HiveField(1)
  back,
  @HiveField(2)
  legs,
  @HiveField(3)
  arms,
  @HiveField(4)
  shoulders,
  @HiveField(5)
  abs,
}
