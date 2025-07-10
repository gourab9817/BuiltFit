import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSettingTile extends StatelessWidget {
  const ThemeSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SettingsNotifier>();
    final index = notifier.settings.themeModeIndex;

    return ListTile(
      title: Text(AppLocalizations.of(context)!.theme),
      subtitle: Text(
        switch (index) {
          1 => AppLocalizations.of(context)!.light,
          2 => AppLocalizations.of(context)!.dark,
          _ => AppLocalizations.of(context)!.system,
        },
      ),
      leading: const Icon(Icons.color_lens_outlined),
      onTap: () => Helpers.showThemeBottomSheet(context),
    );
  }
}
