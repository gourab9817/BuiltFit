import 'package:flutter/material.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'body_part_chip.dart';

class ExerciseTile extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback? onDelete;
  final bool? showDeleteIcon;
  const ExerciseTile(
      {super.key,
      required this.exercise,
      this.onDelete,
      this.showDeleteIcon = true});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (onDelete != null && showDeleteIcon == true)
            ? colorScheme.tertiaryContainer
            : colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onDelete != null && showDeleteIcon == true)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: exercise.assetImagePath != ''
                      ? Image.asset(
                          exercise.assetImagePath,
                          height: 36,
                          width: 36,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.fitness_center,
                            size: 36,
                          ),
                        )
                      : Icon(
                          Icons.fitness_center,
                          size: 36,
                          color: colorScheme.onTertiaryContainer,
                        ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: IconButton.outlined(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 20,
                    ),
                    tooltip: AppLocalizations.of(context)!.deleteExercise,
                  ),
                ),
              ],
            )
          else
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: exercise.assetImagePath != ''
                    ? Image.asset(
                        exercise.assetImagePath,
                        height: 36,
                        width: 36,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.fitness_center,
                          size: 36,
                        ),
                      )
                    : Icon(
                        Icons.fitness_center,
                        size: 36,
                        color: colorScheme.onPrimaryContainer,
                      ),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimaryContainer,
                      ),
                ),
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
        ],
      ),
    );
  }
}
