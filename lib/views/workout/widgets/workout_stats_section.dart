import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/body_part.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'stat_item.dart';

class WorkoutStatsSection extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutStatsSection({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final Map<BodyPart, int> partCount = {};

    int totalSets = 0;
    int totalReps = 0;
    double totalWeight = 0;

    for (final exercise in workout.exercises) {
      totalSets += exercise.sets;
      for (int i = 0; i < exercise.sets; i++) {
        totalReps += exercise.reps[i];
        totalWeight += exercise.reps[i] * exercise.weight[i];
      }
      for (final part in exercise.bodyParts) {
        partCount[part] = (partCount[part] ?? 0) + 1;
      }
    }

    final parts = partCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    parts.sort((a, b) => a.key.name.compareTo(b.key.name));

    String unit = AppLocalizations.of(context)!.weight;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.weightLb;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderDivider(text: AppLocalizations.of(context)!.workoutStats),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatItem(
                  label: AppLocalizations.of(context)!.sets,
                  value: totalSets.toString()),
              StatItem(
                  label: AppLocalizations.of(context)!.reps,
                  value: totalReps.toString()),
              StatItem(label: unit, value: Helpers.formatVolume(totalWeight)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (parts.isNotEmpty)
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: parts.map((entry) {
                  final color = Helpers.mapBodyPartToColor(entry.key);
                  final percent = entry.value / workout.exercises.length * 100;

                  return PieChartSectionData(
                    color: color,
                    value: entry.value.toDouble(),
                    title: '${percent.toStringAsFixed(0)}%',
                    radius: 60,
                    titleStyle:
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 32,
              ),
            ),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            spacing: 12,
            children: parts.map((entry) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Helpers.mapBodyPartToColor(entry.key),
                    ),
                  ),
                  Text(Helpers.mapBodyPartToName(entry.key, context)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
