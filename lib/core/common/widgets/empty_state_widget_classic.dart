import 'package:flutter/material.dart';

class EmptyStateWidgetClassic extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  const EmptyStateWidgetClassic({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.sentiment_dissatisfied_outlined,
            size: 72,
            color: Theme.of(context).colorScheme.primary.withAlpha(125),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
