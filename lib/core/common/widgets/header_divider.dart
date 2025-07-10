import 'package:flutter/material.dart';

class HeaderDivider extends StatelessWidget {
  final String text;
  final Widget? actionButton;
  const HeaderDivider({super.key, required this.text, this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            height: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        if (actionButton != null) ...[
          const SizedBox(
            width: 5,
          ),
          actionButton!,
        ],
      ],
    );
  }
}
