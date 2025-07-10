import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/views/workout/widgets/workout_exercise_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedExercises extends StatelessWidget {
  const SelectedExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
      builder: (context, state) {
        return DragTarget<ExerciseModel>(
          onAcceptWithDetails: (exercise) {
            context
                .read<WorkoutBuilderBloc>()
                .add(AddExerciseToWorkout(exercise.data, context));
          },
          builder: (context, candidateData, rejectedData) {
            final bool isHovering = candidateData.isNotEmpty;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isHovering
                    ? Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(50)
                    : Colors.transparent,
                border: Border.all(
                  color: isHovering
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withAlpha(50)
                          : Colors.white.withAlpha(50),
                  width: isHovering ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: state.selectedExercises.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.dragExerciseHere,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.selectedExercises.length,
                      itemBuilder: (context, index) {
                        return WorkoutExerciseTile(
                          exercise: state.selectedExercises[index],
                          exerciseIndex: index,
                          onRemove: () {
                            context.read<WorkoutBuilderBloc>().add(
                                  RemoveExerciseFromWorkout(
                                    index,
                                  ),
                                );
                          },
                          onMoveUp: () =>
                              context.read<WorkoutBuilderBloc>().add(
                                    ReorderExercise(index, index - 1),
                                  ),
                          onMoveDown: () =>
                              context.read<WorkoutBuilderBloc>().add(
                                    ReorderExercise(index, index + 1),
                                  ),
                          isFirst: index == 0,
                          isLast: index == state.selectedExercises.length - 1,
                          onAddSet: () {
                            final settings =
                                context.read<SettingsNotifier>().settings;
                            final updatedReps = List<int>.from(
                                state.selectedExercises[index].reps)
                              ..add(settings.defaultReps);
                            final updatedWeight = List<double>.from(
                                state.selectedExercises[index].weight)
                              ..add(0);
                            context.read<WorkoutBuilderBloc>().add(
                                  UpdateFullExercise(
                                    exerciseIndex: index,
                                    newSets: updatedReps.length,
                                    newReps: updatedReps,
                                    newWeight: updatedWeight,
                                  ),
                                );
                          },
                          onEditSetDialog: true,
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
