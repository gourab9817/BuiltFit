import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnitsSettingTile extends StatelessWidget {
  const UnitsSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUnit =
        context.watch<SettingsNotifier>().settings.preferredUnit;

    return ListTile(
      title: Text(AppLocalizations.of(context)!.weightUnit),
      subtitle: Text(currentUnit.toUpperCase()),
      leading: const Icon(Icons.scale_outlined),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (_) => const _UnitsBottomSheet(),
      ),
    );
  }
}

class _UnitsBottomSheet extends StatelessWidget {
  const _UnitsBottomSheet();

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<SettingsNotifier>();
    final selected = notifier.settings.preferredUnit;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  AppLocalizations.of(context)!.chooseUnit,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          RadioListTile(
            title: Text(AppLocalizations.of(context)!.kgFull),
            value: AppLocalizations.of(context)!.kg,
            groupValue: selected,
            onChanged: (val) {
              notifier.updatePreferredUnit(val!);
              Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: Text(AppLocalizations.of(context)!.lbFull),
            value: AppLocalizations.of(context)!.lb,
            groupValue: selected,
            onChanged: (val) {
              notifier.updatePreferredUnit(val!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
