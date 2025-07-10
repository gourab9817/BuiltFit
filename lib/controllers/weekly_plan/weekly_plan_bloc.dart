import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notoro/models/workout/workout_model.dart';
import '../../models/dashboard/weekly_plan.dart';
import 'weekly_plan_event.dart';
import 'weekly_plan_state.dart';

class WeeklyPlanBloc extends Bloc<WeeklyPlanEvent, WeeklyPlanState> {
  final Box<WeeklyPlan> planBox;
  final Box<WorkoutModel> workoutBox;
  late final StreamSubscription workoutBoxSub;

  WeeklyPlanBloc({
    required this.planBox,
    required this.workoutBox,
  }) : super(WeeklyPlanState(
            plan: WeeklyPlan(workoutKeys: {
              for (final d in DayOfWeek.values) d: null,
            }),
            availableWorkouts: {})) {
    on<LoadWeeklyPlan>(onLoad);
    on<AssignWorkoutToDay>(onAssign);
    on<RemoveWorkoutFromDay>(onRemove);

    workoutBoxSub = workoutBox.watch().listen((event) {
      add(LoadWeeklyPlan());
    });
  }

  @override
  Future<void> close() {
    workoutBoxSub.cancel();
    return super.close();
  }

  void onLoad(LoadWeeklyPlan event, Emitter<WeeklyPlanState> emit) async {
    var plan = planBox.get('user_plan');

    final workouts = Map<int, WorkoutModel>.fromEntries(
      workoutBox.values.map((workout) => MapEntry(workout.key, workout)),
    );

    emit(state.copyWith(plan: plan, availableWorkouts: workouts));
  }

  void onAssign(AssignWorkoutToDay event, Emitter<WeeklyPlanState> emit) {
    final currentPlan = state.plan ??
        WeeklyPlan(workoutKeys: {
          for (final d in DayOfWeek.values) d: null,
        });

    final updatedKeys = Map<DayOfWeek, int?>.from(currentPlan.workoutKeys)
      ..[event.day] = event.workoutKey;

    final updatedPlan = WeeklyPlan(workoutKeys: updatedKeys);

    planBox.put('user_plan', updatedPlan);
    emit(state.copyWith(plan: updatedPlan));
  }

  void onRemove(RemoveWorkoutFromDay event, Emitter<WeeklyPlanState> emit) {
    final currentPlan = state.plan;
    if (currentPlan == null) return;

    final updatedKeys = Map<DayOfWeek, int?>.from(currentPlan.workoutKeys)
      ..[event.day] = null;

    final updatedPlan = WeeklyPlan(workoutKeys: updatedKeys);
    planBox.put('user_plan', updatedPlan);
    emit(state.copyWith(plan: updatedPlan));
  }
}
