import 'package:flutter/material.dart';
import 'package:notoro/views/home/widgets/rest_slider.dart';

import '../../../models/workout/exercise_training_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExerciseConfigTile extends StatelessWidget {
  final int index;
  final ExerciseTrainingModel exercise;
  final int restBetween;
  final int restAfter;
  final ValueChanged<int> onChangedRestBetween;
  final ValueChanged<int> onChangedRestAfter;
  final bool showRestAfter;

  const ExerciseConfigTile({
    super.key,
    required this.index,
    required this.exercise,
    required this.restBetween,
    required this.restAfter,
    required this.onChangedRestBetween,
    required this.onChangedRestAfter,
    required this.showRestAfter,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
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
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.fitness_center,
                                size: 30,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.fitness_center,
                            size: 30,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    exercise.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RestSlider(
                    label: AppLocalizations.of(context)!.setRest,
                    value: restBetween,
                    onChanged: onChangedRestBetween,
                  ),
                ),
              ],
            ),
            if (showRestAfter) const SizedBox(height: 8),
            if (showRestAfter)
              Row(
                children: [
                  Expanded(
                    child: RestSlider(
                      label: AppLocalizations.of(context)!.setRestAfter,
                      value: restAfter,
                      onChanged: onChangedRestAfter,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
