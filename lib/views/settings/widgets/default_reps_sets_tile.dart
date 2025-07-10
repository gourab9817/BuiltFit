// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultRepsAndSetsTile extends StatelessWidget {
  const DefaultRepsAndSetsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsNotifier>().settings;

    return ListTile(
      title: Text(AppLocalizations.of(context)!.defaultSetsExercises),
      subtitle: Text(
          '${settings.defaultSets} ${AppLocalizations.of(context)!.setsLowercase} • ${settings.defaultReps} ${AppLocalizations.of(context)!.repsShort}'),
      leading: const Icon(Icons.fitness_center_outlined),
      onTap: () async {
        final result = await showDialog<List<int>>(
          context: context,
          builder: (_) => _RepsAndSetsDialog(
            initialReps: settings.defaultReps,
            initialSets: settings.defaultSets,
          ),
        );

        if (result != null && result.length == 2) {
          context
              .read<SettingsNotifier>()
              .updateDefaultRepsAndSets(result[0], result[1]);
        }
      },
    );
  }
}

class _RepsAndSetsDialog extends StatefulWidget {
  final int initialReps;
  final int initialSets;

  const _RepsAndSetsDialog(
      {required this.initialReps, required this.initialSets});

  @override
  State<_RepsAndSetsDialog> createState() => _RepsAndSetsDialogState();
}

class _RepsAndSetsDialogState extends State<_RepsAndSetsDialog> {
  late int reps;
  late int sets;

  @override
  void initState() {
    super.initState();
    reps = widget.initialReps;
    sets = widget.initialSets;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.setDefaultValues),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('${AppLocalizations.of(context)!.reps}:'),
              const Spacer(),
              DropdownButton<int>(
                dropdownColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                menuMaxHeight: 300,
                value: reps,
                items: List.generate(20, (i) => i + 1)
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (val) => setState(() => reps = val!),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('${AppLocalizations.of(context)!.sets}:'),
              const Spacer(),
              DropdownButton<int>(
                dropdownColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                menuMaxHeight: 300,
                value: sets,
                items: List.generate(10, (i) => i + 1)
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (val) => setState(() => sets = val!),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text(AppLocalizations.of(context)!.save),
          onPressed: () => Navigator.pop(context, [reps, sets]),
        ),
      ],
    );
  }
}
