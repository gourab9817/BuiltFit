// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_event.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_state.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/dashboard/weekly_plan.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeeklyPlanSection extends StatefulWidget {
  const WeeklyPlanSection({super.key});

  @override
  State<WeeklyPlanSection> createState() => _WeeklyPlanSectionState();
}

class _WeeklyPlanSectionState extends State<WeeklyPlanSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeeklyPlanBloc, WeeklyPlanState>(
      builder: (context, state) {
        final plan = state.plan!;
        final workouts = state.availableWorkouts;
        final today = Helpers.getTodayEnum();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderDivider(
              text: AppLocalizations.of(context)!.weeklyPlan,
              actionButton: Transform.rotate(
                angle: !isExpanded ? 90 * 3.14 / 180 : 270 * 3.14 / 180,
                child: IconButton(
                  icon: Icon(Icons.arrow_back,
                      size: 30, color: Theme.of(context).colorScheme.onPrimary),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: DayOfWeek.values.map((day) {
                final workoutKey = plan.workoutKeys[day];
                final workout =
                    workoutKey != null ? workouts[workoutKey] : null;
                final isToday = day == today;

                return (!isExpanded && !isToday)
                    ? const SizedBox.shrink()
                    : Card(
                        margin: const EdgeInsets.only(bottom: 6),
                        color: isToday
                            ? Theme.of(context).colorScheme.tertiaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh,
                        elevation: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            if (workouts.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackbar.show(
                                  context: context,
                                  message: AppLocalizations.of(context)!
                                      .noWorkoutsAvailable,
                                ),
                              );
                              return;
                            }

                            final selectedKey =
                                await Helpers.showWorkoutPickerDialog(
                              context: context,
                              availableWorkouts: workouts,
                            );
                            if (selectedKey != null && selectedKey != -1) {
                              context.read<WeeklyPlanBloc>().add(
                                    AssignWorkoutToDay(
                                        day: day, workoutKey: selectedKey),
                                  );
                            } else if (selectedKey == -1) {
                              context.read<WeeklyPlanBloc>().add(
                                    RemoveWorkoutFromDay(day),
                                  );
                            }
                          },
                          onLongPress: () {
                            if (workoutKey != null) {
                              context.read<WeeklyPlanBloc>().add(
                                    RemoveWorkoutFromDay(day),
                                  );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    workout != null
                                        ? Icons.fitness_center
                                        : Icons
                                            .sentiment_satisfied_alt_outlined,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Helpers.mapDayOfWeekToName(
                                            day, context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: isToday
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .onTertiaryContainer
                                                  : null,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        workout?.name ??
                                            AppLocalizations.of(context)!
                                                .noWorkout,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: today == day
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .onTertiaryContainer
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      if (workout != null)
                                        Wrap(
                                          spacing: 4,
                                          runSpacing: 4,
                                          children: [
                                            ...workout.exercises.take(8).map(
                                                  (exercise) => ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: exercise
                                                                .assetImagePath !=
                                                            ''
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            child: Image.asset(
                                                              exercise
                                                                  .assetImagePath,
                                                              width: 18,
                                                              height: 18,
                                                              errorBuilder:
                                                                  (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Icon(
                                                                Icons
                                                                    .fitness_center,
                                                                size: 18,
                                                              ),
                                                            ),
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .fitness_center,
                                                            size: 18,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimaryContainer,
                                                          ),
                                                  ),
                                                ),
                                            if (workout.exercises.length > 8)
                                              Text(
                                                '+${workout.exercises.length - 8}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                                    ),
                                              ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
