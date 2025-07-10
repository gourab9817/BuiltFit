import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/body_part.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MuscleGroupPieChart extends StatelessWidget {
  final Map<BodyPart, int> data;

  const MuscleGroupPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (entries.isEmpty) {
      return SizedBox.shrink();
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
        Text(
          AppLocalizations.of(context)!.favParts,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: entries.map((entry) {
                final color = Helpers.mapBodyPartToColor(entry.key);
                final percent =
                    (entry.value / entries.fold(0, (sum, e) => sum + e.value)) *
                        100;

                return PieChartSectionData(
                  color: color,
                  value: entry.value.toDouble(),
                  title: '${percent.toStringAsFixed(0)}%',
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
}
