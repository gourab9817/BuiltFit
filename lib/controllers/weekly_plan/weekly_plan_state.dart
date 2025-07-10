import 'package:equatable/equatable.dart';
import 'package:notoro/models/workout/workout_model.dart';

import '../../models/dashboard/weekly_plan.dart';

class WeeklyPlanState extends Equatable {
  final WeeklyPlan? plan;
  final Map<int, WorkoutModel> availableWorkouts;

  const WeeklyPlanState({
    required this.plan,
    required this.availableWorkouts,
  });

  WeeklyPlanState copyWith({
    WeeklyPlan? plan,
    Map<int, WorkoutModel>? availableWorkouts,
  }) {
    return WeeklyPlanState(
      plan: plan ?? this.plan,
      availableWorkouts: availableWorkouts ?? this.availableWorkouts,
    );
  }

  @override
  List<Object?> get props => [plan ?? '', availableWorkouts];
}
