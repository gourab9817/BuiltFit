import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeightProgressChart extends StatelessWidget {
  final Map<DateTime, double> data;

  const WeightProgressChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final sorted = data.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    if (sorted.last.value == 0) {
      return const SizedBox.shrink();
    }

    final spots = List.generate(sorted.length, (i) {
      return FlSpot(i.toDouble(), sorted[i].value);
    });

    if (spots.length == 1) {
      spots.insert(0, FlSpot(spots.first.x - 1, 0));
    }

    final totalWeeks = sorted.length;
    final maxValue = sorted
        .map((e) => e.value)
        .fold<double>(0, (prev, curr) => prev > curr ? prev : curr);
    final lastWeek = sorted.last;

    String unit = AppLocalizations.of(context)!.kg;
    unit = context.watch<SettingsNotifier>().settings.preferredUnit;
    if (unit == 'lb') {
      unit = AppLocalizations.of(context)!.lb;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 2,
          height: 20,
        ),
        const SizedBox(height: 12),
        Text(AppLocalizations.of(context)!.weightWeeklyProgress,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          '${AppLocalizations.of(context)!.weeks}: $totalWeeks • ${AppLocalizations.of(context)!.most}: ${maxValue.toStringAsFixed(0)} $unit • ${AppLocalizations.of(context)!.last}: ${lastWeek.value.toStringAsFixed(0)} $unit',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  dotData: FlDotData(show: false),
                  color: Theme.of(context).colorScheme.primary,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  ),
                ),
              ],
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              lineTouchData: LineTouchData(
                enabled: false,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final index = spot.x.toInt();
                      final date = sorted[index].key;
                      return LineTooltipItem(
                        '${date.day}.${date.month} ${sorted[index].value.toStringAsFixed(0)} kg',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
