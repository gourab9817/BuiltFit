// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notoro/controllers/active_workout/workout_session_controller.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/views/home/widgets/next_exercise_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../workout_summary_view.dart';
import 'workout_session_card.dart';

class WorkoutSessionBody extends StatelessWidget {
  const WorkoutSessionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutSessionController>(
      builder: (context, controller, _) {
        final theme = Theme.of(context);

        if (controller.isFinished) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final history = controller.saveToHistory(isAbandoned: false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => WorkoutSummaryView(history: history),
              ),
            );
          });
        }

        final exercise = controller.currentExerciseModel;
        final setIndex = controller.currentSet;
        final isRest = controller.isResting;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final shouldExit = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.terminateWorkout),
                content: Text(
                    AppLocalizations.of(context)!.terminateWorkoutSubtitle),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(AppLocalizations.of(context)!.terminate),
                  ),
                ],
              ),
            );

            if (shouldExit == true) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: CommonAppbar(
              title: AppLocalizations.of(context)!.workout,
              onBackPressed: () async {
                final shouldExit = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.terminateWorkout),
                    content: Text(
                        AppLocalizations.of(context)!.terminateWorkoutSubtitle),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(AppLocalizations.of(context)!.terminate),
                      ),
                    ],
                  ),
                );

                if (shouldExit == true) {
                  Navigator.of(context).pop();
                }
              },
              actions: [
                IconButton(
                  icon: Icon(
                      controller.isPaused ? Icons.play_arrow : Icons.pause),
                  tooltip: controller.isPaused
                      ? AppLocalizations.of(context)!.resume
                      : AppLocalizations.of(context)!.pause,
                  onPressed: () {
                    if (controller.isPaused) {
                      controller.resumeWorkout();
                    } else {
                      controller.pauseWorkout();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      Helpers.formatDuration(controller.elapsed),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
            body: controller.isPaused
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.pause_circle_outline, size: 64),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.workoutPaused,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                              onPressed: controller.resumeWorkout,
                              icon: const Icon(Icons.play_arrow),
                              label: Text(AppLocalizations.of(context)!.resume),
                            ),
                            const SizedBox(width: 16),
                            FilledButton.icon(
                              onPressed: () async {
                                final shouldExit = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!
                                        .finishWorkoutQuestion),
                                    content: Text(AppLocalizations.of(context)!
                                        .terminateWorkoutSubtitleShort),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .cancel),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .finish),
                                      )
                                    ],
                                  ),
                                );
                                if (shouldExit == true) {
                                  controller.abandon();
                                  final history = controller.saveToHistory(
                                      isAbandoned: true);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          WorkoutSummaryView(history: history),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.stop_circle_outlined),
                              label: Text(AppLocalizations.of(context)!.finish),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        WorkoutSessionCard(
                          isRest: isRest,
                          exercise: exercise,
                          setIndex: setIndex,
                          controller: controller,
                        ),
                        if (!isRest && controller.hasNextExercise)
                          NextExerciseCard(
                              nextExerciseName: controller.nextExerciseName),
                        const Spacer(),
                        if (isRest)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton.icon(
                                onPressed: controller.add15sRest,
                                icon: const Icon(Icons.add),
                                label: Text(
                                  AppLocalizations.of(context)!.addSecs,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                              ),
                            ],
                          )
                        else
                          FilledButton.icon(
                            onPressed: controller.finishSet,
                            icon: Icon(
                              Icons.check_circle_outline,
                              size: 25,
                            ),
                            label: Text(
                              (controller.isLastSet & controller.isLastExercise)
                                  ? AppLocalizations.of(context)!.finishWorkout
                                  : controller.isLastSet
                                      ? AppLocalizations.of(context)!
                                          .finishExercise
                                      : AppLocalizations.of(context)!.endSet,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(60),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
