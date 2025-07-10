import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/views/workout/widgets/stat_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/common/widgets/header_divider.dart';
import '../../../models/history/history_model.dart';
import '../../../models/workout/body_part.dart';
import 'muscle_group_pie_chart.dart';
import 'weekday_frequency_chart.dart';
import 'weight_progress_chart.dart';

class GlobalStatsContent extends StatelessWidget {
  final List<HistoryModel> history;

  const GlobalStatsContent({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    int totalWorkouts = history.length;
    double totalWeight = 0;
    final Map<DateTime, double> weeklyWeight = {};
    final Map<int, int> weekdayCount = {};
    int? maxLoad = 0;

    for (final item in history) {
      final filteredExercises = Helpers.filterValidExercises(item);
      final day = DateTime(item.date.year, item.date.month, item.date.day);
      final weekStart = day.subtract(Duration(days: day.weekday - 1));
      double dayWeight = 0;

      for (final ex in filteredExercises) {
        for (int i = 0; i < ex.sets; i++) {
          final w = ex.weight[i] * ex.reps[i];
          totalWeight += w;
          dayWeight += w;
          maxLoad = maxLoad != null ? max(maxLoad, w.toInt()) : w.toInt();
        }
      }

      weeklyWeight[weekStart] = (weeklyWeight[weekStart] ?? 0) + dayWeight;
      weekdayCount[item.date.weekday] =
          (weekdayCount[item.date.weekday] ?? 0) + 1;
    }

    String unit = AppLocalizations.of(context)!.kg;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.lb;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderDivider(text: AppLocalizations.of(context)!.yourStats),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatItem(
                label: AppLocalizations.of(context)!.workouts,
                value: totalWorkouts.toString()),
            StatItem(
                label: AppLocalizations.of(context)!.weightShort,
                value: '${Helpers.formatVolume(totalWeight)} $unit'),
            StatItem(
                label: AppLocalizations.of(context)!.sets,
                value: history.fold<int>(0, (sum, item) {
                  final filteredExercises = Helpers.filterValidExercises(item);
                  return sum +
                      filteredExercises.fold<int>(0, (sum, ex) {
                        return sum + ex.sets;
                      });
                }).toString()),
          ],
        ),
        if (maxLoad != null && maxLoad > 0) const SizedBox(height: 24),
        if (maxLoad != null && maxLoad > 0)
          Center(
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: AppLocalizations.of(context)!.mostWeight,
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: '$maxLoad $unit',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                )),
          ),
        const SizedBox(height: 12),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 2,
          height: 20,
        ),
        const SizedBox(height: 12),
        WeekdayFrequencyChart(data: weekdayCount),
        MuscleGroupPieChart(
          data: _aggregateParts(history),
        ),
        WeightProgressChart(data: weeklyWeight),
      ],
    );
  }

  Map<BodyPart, int> _aggregateParts(List<HistoryModel> history) {
    final Map<BodyPart, int> partCount = {};
    for (final workout in history) {
      final filtered = Helpers.filterValidExercises(workout);
      for (final ex in filtered) {
        for (final part in ex.bodyParts) {
          partCount[part] = (partCount[part] ?? 0) + 1;
        }
      }
    }
    return partCount;
  }
}
