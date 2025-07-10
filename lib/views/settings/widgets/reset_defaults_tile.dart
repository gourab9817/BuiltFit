import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetToDefaultsTile extends StatelessWidget {
  const ResetToDefaultsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<SettingsNotifier>();

    return ListTile(
      title: Text(AppLocalizations.of(context)!.resetDefaultsTile),
      leading: const Icon(Icons.restore_outlined),
      onTap: () async {
        final confirm = await Helpers.showDeleteConfirmationDialog(
          context: context,
          title: AppLocalizations.of(context)!.resetDefaults,
          content: AppLocalizations.of(context)!.resetDefaultsSubtitle,
          confirmText: AppLocalizations.of(context)!.yes,
          isNegative: false,
        );
        if (confirm == true) {
          notifier.resetToDefaults();
        }
      },
    );
  }
}
