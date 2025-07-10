import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/workout/body_part.dart';
import '../workout/widgets/stat_item.dart';

class WorkoutSummaryView extends StatelessWidget {
  final HistoryModel history;

  const WorkoutSummaryView({super.key, required this.history});

  List<ExerciseTrainingModel> get filteredExercises =>
      Helpers.filterValidExercises(history);

  Map<int, List<Duration>> get filteredDurations {
    if (!history.wasAbandoned ||
        history.interruptedExerciseIndex == null ||
        history.interruptedSetIndex == null) {
      return history.setDurations;
    }

    final filtered = <int, List<Duration>>{};
    final exIndex = history.interruptedExerciseIndex!;
    final setIndex = history.interruptedSetIndex!;

    history.setDurations.forEach((i, durations) {
      if (i < exIndex) {
        filtered[i] = durations;
      } else if (i == exIndex) {
        filtered[i] = durations.take(setIndex).toList();
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: AppLocalizations.of(context)!.summary,
        onBackPressed: () =>
            Navigator.popUntil(context, (route) => route.isFirst),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
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
                    child: const Icon(
                      Icons.fitness_center,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  history.workoutName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatsGrid(context),
            _buildVolumeChart(context),
            _buildBodyPartDistribution(context),
            const SizedBox(height: 20),
            if (history.wasAbandoned) _buildAbandonedBanner(context),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              icon: const Icon(Icons.home),
              label: Text(AppLocalizations.of(context)!.backToHome),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    String unit = AppLocalizations.of(context)!.volume;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.volumeLb;
    }
    final totalSets =
        filteredExercises.fold<int>(0, (sum, ex) => sum + ex.sets);

    final totalVolume = filteredExercises.fold<double>(0.0, (sum, ex) {
      for (int i = 0; i < ex.sets; i++) {
        sum += ex.reps[i] * ex.weight[i];
      }
      return sum;
    });

    final totalSetDurations = filteredDurations.values
        .expand((list) => list)
        .fold<Duration>(Duration.zero, (sum, d) => sum + d);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatItem(
            label: AppLocalizations.of(context)!.workoutTime,
            value: Helpers.formatDuration(history.duration)),
        StatItem(
            label: AppLocalizations.of(context)!.sets, value: '$totalSets'),
        StatItem(label: unit, value: Helpers.formatVolume(totalVolume)),
        StatItem(
            label: AppLocalizations.of(context)!.trainingTime,
            value: Helpers.formatDuration(totalSetDurations)),
      ],
    );
  }

  Widget _buildVolumeChart(BuildContext context) {
    final data = <String, double>{};

    for (final ex in filteredExercises) {
      double volume = 0;
      for (int i = 0; i < ex.sets; i++) {
        volume += ex.reps[i] * ex.weight[i];
      }
      data[ex.name] = volume;
    }

    final entries = data.entries.toList();

    if (entries.isEmpty) {
      return SizedBox.shrink();
    }

    String unit = AppLocalizations.of(context)!.kg;
    String unitVolume = AppLocalizations.of(context)!.volumePerExercise;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.lb;
      unitVolume = AppLocalizations.of(context)!.volumePerExerciseLb;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 2,
          height: 20,
        ),
        const SizedBox(height: 10),
        Text(unitVolume, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(entries.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: entries[index].value,
                      width: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                );
              }),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final name = entries[group.x].key;
                    final value = entries[group.x].value;
                    return BarTooltipItem(
                      '$name\n${value.toStringAsFixed(1)} $unit',
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyPartDistribution(BuildContext context) {
    final parts = <BodyPart, int>{};

    for (final ex in filteredExercises) {
      for (final part in ex.bodyParts) {
        parts[part] = (parts[part] ?? 0) + 1;
      }
    }

    final entries = parts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (entries.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 2,
          height: 20,
        ),
        const SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.partsUsed,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: entries.map((entry) {
                final percent =
                    (entry.value / entries.fold(0, (sum, e) => sum + e.value)) *
                        100;
                return PieChartSectionData(
                  value: entry.value.toDouble(),
                  title: '${percent.toStringAsFixed(0)}%',
                  color: Helpers.mapBodyPartToColor(entry.key),
                  titleStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  radius: 50,
                );
              }).toList(),
              centerSpaceRadius: 32,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: entries.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Helpers.mapBodyPartToColor(entry.key),
                  ),
                ),
                const SizedBox(width: 6),
                Text(Helpers.mapBodyPartToName(entry.key, context)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAbandonedBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.workoutWasAbandoned,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red.shade800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
