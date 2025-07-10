import 'package:flutter/material.dart';
import 'package:notoro/controllers/active_workout/workout_session_controller.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkoutSessionCard extends StatelessWidget {
  final bool isRest;
  final ExerciseTrainingModel exercise;
  final int setIndex;
  final WorkoutSessionController controller;

  const WorkoutSessionCard({
    super.key,
    required this.isRest,
    required this.exercise,
    required this.setIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String unit = AppLocalizations.of(context)!.kg;
    String unitWeight = AppLocalizations.of(context)!.weight;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.lb;
      unitWeight = AppLocalizations.of(context)!.weightLb;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (isRest) ...[
              Text(
                AppLocalizations.of(context)!.rest,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                Helpers.formatDuration(controller.restRemaining),
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                controller.isLastSetExercise
                    ? AppLocalizations.of(context)!.restExerciseSubtitle
                    : AppLocalizations.of(context)!.restSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ] else ...[
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: exercise.assetImagePath != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                exercise.assetImagePath,
                                width: 32,
                                height: 32,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.fitness_center,
                                  size: 25,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.fitness_center,
                              size: 25,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      exercise.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${AppLocalizations.of(context)!.set} ${setIndex + 1} / ${exercise.sets}',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${exercise.reps[setIndex]} ${AppLocalizations.of(context)!.repsShort} • ${exercise.weight[setIndex]} $unit',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Helpers.showEditSetDialogOnSession(
                      context, controller, setIndex, unitWeight);
                },
                icon: const Icon(Icons.edit),
                label: Text(AppLocalizations.of(context)!.changeValue),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
