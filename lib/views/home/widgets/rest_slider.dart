import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestSlider extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const RestSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value ${AppLocalizations.of(context)!.sec}',
            style: Theme.of(context).textTheme.labelMedium),
        Slider(
          value: value.toDouble(),
          min: 15,
          max: 180,
          divisions: 11,
          label: '$value ${AppLocalizations.of(context)!.secVeryShort}',
          onChanged: (val) => onChanged(val.round()),
        ),
      ],
    );
  }
}
