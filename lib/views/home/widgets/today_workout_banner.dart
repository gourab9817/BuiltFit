import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_state.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/views/home/workout_configuration_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayWorkoutBanner extends StatelessWidget {
  const TodayWorkoutBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeeklyPlanBloc, WeeklyPlanState>(
      builder: (context, state) {
        final plan = state.plan;
        if (plan == null) return const SizedBox.shrink();

        final today = Helpers.getTodayEnum();
        final workoutKey = plan.workoutKeys[today];

        if (workoutKey == null) return const SizedBox.shrink();
        final workout = state.availableWorkouts[workoutKey];
        if (workout == null) return const SizedBox.shrink();

        final historyBox = Hive.box<HistoryModel>('workout_history');

        final hasDoneToday = historyBox.values.any((entry) {
          return entry.workoutName == workout.name &&
              DateUtils.isSameDay(entry.date, DateTime.now());
        });

        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.todayWorkout} ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: workout.name,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            trailing: FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkoutConfigurationView(workout: workout),
                  ),
                );
              },
              icon: Icon(
                hasDoneToday ? Icons.replay : Icons.play_arrow,
                size: 20,
              ),
              label: Text(hasDoneToday
                  ? AppLocalizations.of(context)!.repeatWorkout
                  : AppLocalizations.of(context)!.startWorkout),
            ),
          ),
        );
      },
    );
  }
}
