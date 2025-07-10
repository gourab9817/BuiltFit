import 'package:hive_flutter/hive_flutter.dart';

part 'weekly_plan.g.dart';

@HiveType(typeId: 5)
class WeeklyPlan extends HiveObject {
  @HiveField(0)
  final Map<DayOfWeek, int?> workoutKeys;

  WeeklyPlan({required this.workoutKeys});
}

@HiveType(typeId: 6)
enum DayOfWeek {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
  @HiveField(6)
  sunday,
}
