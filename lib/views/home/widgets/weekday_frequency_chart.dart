import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeekdayFrequencyChart extends StatelessWidget {
  final Map<int, int> data;

  const WeekdayFrequencyChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final days = List.generate(7, (i) => i + 1);
    final maxValue = data.values.fold<int>(0, max);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.mostFrequentDays,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              barGroups: days.map((d) {
                final value = data[d] ?? 0;
                return BarChartGroupData(
                  x: d,
                  barRods: [
                    BarChartRodData(
                      toY: value.toDouble(),
                      width: 18,
                      color: value == maxValue
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                );
              }).toList(),
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
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final names = [
                        AppLocalizations.of(context)!.mondayShort,
                        AppLocalizations.of(context)!.tuesdayShort,
                        AppLocalizations.of(context)!.wednesdayShort,
                        AppLocalizations.of(context)!.thursdayShort,
                        AppLocalizations.of(context)!.fridayShort,
                        AppLocalizations.of(context)!.saturdayShort,
                        AppLocalizations.of(context)!.sundayShort,
                      ];
                      return Text(names[value.toInt() - 1]);
                    },
                  ),
                ),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final day = [
                      AppLocalizations.of(context)!.mondayShort,
                      AppLocalizations.of(context)!.tuesdayShort,
                      AppLocalizations.of(context)!.wednesdayShort,
                      AppLocalizations.of(context)!.thursdayShort,
                      AppLocalizations.of(context)!.fridayShort,
                      AppLocalizations.of(context)!.saturdayShort,
                      AppLocalizations.of(context)!.sundayShort,
                    ][group.x.toInt() - 1];
                    return BarTooltipItem(
                      '$day\n${rod.toY.toStringAsFixed(0)}',
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
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
