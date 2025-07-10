import 'package:flutter/material.dart';
import 'package:notoro/core/helpers/helpers.dart';

import '../../../models/workout/body_part.dart';

class BodyPartChip extends StatelessWidget {
  final BodyPart part;
  const BodyPartChip({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    final icon = Helpers.mapBodyPartToString(part);
    final name = Helpers.mapBodyPartToName(part, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              icon,
              height: 20,
              width: 20,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.fitness_center,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            name,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
