import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/exercise_config_tile.dart';
import 'workout_session_view.dart';

class WorkoutConfigurationView extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutConfigurationView({super.key, required this.workout});

  @override
  State<WorkoutConfigurationView> createState() =>
      _WorkoutConfigurationViewState();
}

class _WorkoutConfigurationViewState extends State<WorkoutConfigurationView> {
  final Map<int, int> restBetweenSets = {};
  final Map<int, int> restAfterExercise = {};

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsNotifier>().settings;
    for (int i = 0; i < widget.workout.exercises.length; i++) {
      restBetweenSets[i] = settings.defaultRestBetweenSets;
      restAfterExercise[i] = settings.defaultRestBetweenExercises;
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercises = widget.workout.exercises;

    return Scaffold(
      appBar: CommonAppbar(title: AppLocalizations.of(context)!.prepareWorkout),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.configureRest,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ex = exercises[index];
                  final isLast = index == exercises.length - 1;
                  return ExerciseConfigTile(
                    index: index,
                    exercise: ex,
                    restBetween: restBetweenSets[index]!,
                    restAfter: restAfterExercise[index]!,
                    onChangedRestBetween: (value) {
                      setState(() {
                        restBetweenSets[index] = value;
                      });
                    },
                    onChangedRestAfter: (value) {
                      setState(() {
                        restAfterExercise[index] = value;
                      });
                    },
                    showRestAfter: !isLast,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutSessionView(
                      workout: widget.workout,
                      restBetweenSets: restBetweenSets,
                      restAfterExercises: restAfterExercise,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: Text(AppLocalizations.of(context)!.startWorkoutLong),
            ),
          ],
        ),
      ),
    );
  }
}
