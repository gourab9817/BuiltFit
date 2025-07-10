import 'package:equatable/equatable.dart';

import '../../models/dashboard/weekly_plan.dart';

abstract class WeeklyPlanEvent extends Equatable {
  const WeeklyPlanEvent();

  @override
  List<Object?> get props => [];
}

class LoadWeeklyPlan extends WeeklyPlanEvent {}

class AssignWorkoutToDay extends WeeklyPlanEvent {
  final DayOfWeek day;
  final int workoutKey;

  const AssignWorkoutToDay({
    required this.day,
    required this.workoutKey,
  });

  @override
  List<Object?> get props => [day, workoutKey];
}

class RemoveWorkoutFromDay extends WeeklyPlanEvent {
  final DayOfWeek day;

  const RemoveWorkoutFromDay(this.day);

  @override
  List<Object?> get props => [day];
}
