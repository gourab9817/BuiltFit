import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/views/settings/widgets/default_rest_sets.dart';
import 'package:notoro/views/settings/widgets/settings_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/about_app_tile.dart';
import 'widgets/clear_all_data_tile.dart';
import 'widgets/deafault_rest_exercises.dart';
import 'widgets/default_reps_sets_tile.dart';
import 'widgets/language_setting_tile.dart';
import 'widgets/reset_defaults_tile.dart';
import 'widgets/theme_settings_tile.dart';
import 'widgets/unit_settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.settings_outlined,
        title: AppLocalizations.of(context)!.settings,
      ),
      body: ListView(
        children: [
          SettingsSection(
            title: AppLocalizations.of(context)!.general,
            children: [
              ThemeSettingTile(),
              UnitsSettingTile(),
              LanguageSettingTile(),
            ],
          ),
          SettingsSection(
            title: AppLocalizations.of(context)!.training,
            children: [
              DefaultRestBetweenSetsTile(),
              DefaultRestBetweenExercisesTile(),
              DefaultRepsAndSetsTile(),
            ],
          ),
          SettingsSection(
            title: AppLocalizations.of(context)!.data,
            children: [
              ClearAllDataTile(),
              ResetToDefaultsTile(),
            ],
          ),
          SettingsSection(
            title: AppLocalizations.of(context)!.info,
            children: [
              AboutAppTile(),
            ],
          ),
        ],
      ),
    );
  }
}
