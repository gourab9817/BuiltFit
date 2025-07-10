// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/dashboard/weekly_plan.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/models/settings/app_settings_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/workout_model.dart';

class ClearAllDataTile extends StatelessWidget {
  const ClearAllDataTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete_forever_outlined),
      title: Text(AppLocalizations.of(context)!.clearAllData),
      onTap: () async {
        final confirm = await Helpers.showDeleteConfirmationDialog(
          context: context,
          title: AppLocalizations.of(context)!.clearAllData,
          content: AppLocalizations.of(context)!.clearAllDataSubtitle,
          confirmText: AppLocalizations.of(context)!.remove,
          isNegative: true,
        );
        if (confirm == true) {
          await Hive.box<WorkoutModel>('workouts').clear();
          await Hive.box<HistoryModel>('workout_history').clear();
          await Hive.box<ExerciseModel>('custom_exercises').clear();
          await Hive.box<WeeklyPlan>('user_plan').clear();
          await Hive.box<AppSettingsModel>('app_settings').clear();

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackbar.show(
              context: context,
              message: AppLocalizations.of(context)!.allDataCleared,
            ),
          );
        }
      },
    );
  }
}
