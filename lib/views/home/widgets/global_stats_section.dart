import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/models/history/history_model.dart';

import '../../../core/common/widgets/empty_state_widget_classic.dart';
import '../../../core/common/widgets/header_divider.dart';
import 'global_stats_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalStatsSection extends StatelessWidget {
  const GlobalStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<HistoryModel>>(
      valueListenable: Hive.box<HistoryModel>('workout_history').listenable(),
      builder: (context, box, _) {
        final history = box.values.toList()
          ..sort((a, b) => a.date.compareTo(b.date));

        if (history.isEmpty) {
          return Column(
            children: [
              HeaderDivider(text: AppLocalizations.of(context)!.yourStats),
              const SizedBox(height: 12),
              EmptyStateWidgetClassic(
                title: AppLocalizations.of(context)!.noData,
                subtitle: AppLocalizations.of(context)!.noDataSubtitle,
              ),
            ],
          );
        }

        return GlobalStatsContent(history: history);
      },
    );
  }
}
