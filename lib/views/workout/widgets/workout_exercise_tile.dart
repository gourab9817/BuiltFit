import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'body_part_chip.dart';

class WorkoutExerciseTile extends StatelessWidget {
  final ExerciseTrainingModel exercise;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final VoidCallback onAddSet;
  final bool onEditSetDialog;
  final bool onEditSetDialogWorkout;
  final bool isFirst;
  final bool isLast;
  final int exerciseIndex;

  const WorkoutExerciseTile({
    super.key,
    required this.exercise,
    required this.onRemove,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.isFirst,
    required this.isLast,
    required this.exerciseIndex,
    required this.onAddSet,
    this.onEditSetDialog = false,
    this.onEditSetDialogWorkout = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String unit = AppLocalizations.of(context)!.kg;
    String unitWeight = AppLocalizations.of(context)!.weight;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.lb;
      unitWeight = AppLocalizations.of(context)!.weightLb;
    }

    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: exercise.assetImagePath != ''
                      ? Image.asset(
                          exercise.assetImagePath,
                          width: 56,
                          height: 56,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.fitness_center,
                            size: 56,
                          ),
                        )
                      : Icon(
                          Icons.fitness_center,
                          size: 56,
                          color: colorScheme.onPrimaryContainer,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        exercise.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: exercise.bodyParts
                              .map((part) => BodyPartChip(part: part))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.outlined(
                  onPressed: () async {
                    final shouldDelete =
                        await Helpers.showDeleteConfirmationDialog(
                            context: context,
                            title: AppLocalizations.of(context)!.removeExercise,
                            content: AppLocalizations.of(context)!
                                .removeExerciseConfirmation,
                            confirmText: AppLocalizations.of(context)!.remove,
                            isNegative: true);
                    if (shouldDelete == true) {
                      onRemove();
                    }
                  },
                  icon: const Icon(Icons.delete_outline, size: 20),
                  tooltip: AppLocalizations.of(context)!.deleteExercise,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: -2,
                    children: [
                      ...List.generate(
                        exercise.sets,
                        (index) {
                          return ActionChip(
                            onPressed: onEditSetDialog
                                ? () {
                                    Helpers.showEditSetDialog(
                                      context: context,
                                      index: index,
                                      exercise: exercise,
                                      exerciseIndex: exerciseIndex,
                                      unit: unitWeight,
                                    );
                                  }
                                : () {
                                    Helpers.showEditSetDialogWorkout(
                                      context: context,
                                      index: index,
                                      exercise: exercise,
                                      exerciseIndex: exerciseIndex,
                                      unit: unitWeight,
                                    );
                                  },
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            label: Text(
                              '${exercise.reps[index]}x${exercise.weight[index]}$unit',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                      ActionChip(
                        label: Text(
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        visualDensity: VisualDensity.compact,
                        onPressed: onAddSet,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_upward, size: 20),
                      tooltip: AppLocalizations.of(context)!.moveUp,
                      onPressed: isFirst ? null : onMoveUp,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward, size: 20),
                      tooltip: AppLocalizations.of(context)!.moveDown,
                      onPressed: isLast ? null : onMoveDown,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
