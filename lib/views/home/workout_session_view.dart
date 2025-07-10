import 'package:flutter/material.dart';
import 'package:notoro/controllers/active_workout/workout_session_controller.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:provider/provider.dart';

import 'widgets/workout_session_body.dart';

class WorkoutSessionView extends StatelessWidget {
  final WorkoutModel workout;
  final Map<int, int> restBetweenSets;
  final Map<int, int> restAfterExercises;

  const WorkoutSessionView({
    super.key,
    required this.workout,
    required this.restBetweenSets,
    required this.restAfterExercises,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkoutSessionController(
        workout: workout,
        restBetweenSets: restBetweenSets,
        restAfterExercises: restAfterExercises,
      ),
      child: const WorkoutSessionBody(),
    );
  }
}
