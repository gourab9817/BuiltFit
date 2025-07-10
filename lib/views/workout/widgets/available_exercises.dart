import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/views/workout/widgets/exercise_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvailableExercises extends StatelessWidget {
  const AvailableExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
        builder: (context, state) {
          state.availableExercises.sort(
            (a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()),
          );
          var availableExercises = state.availableExercises.toList();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: availableExercises.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final exercise = availableExercises[index];

              return LongPressDraggable<ExerciseModel>(
                data: exercise,
                feedback: Material(
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0.9,
                    child: SizedBox(
                      width: 220,
                      child: ExerciseTile(
                        exercise: exercise,
                        showDeleteIcon: false,
                      ),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 220,
                  child: ExerciseTile(
                    exercise: exercise,
                    onDelete: exercise.isCustom
                        ? () async {
                            final shouldDelete =
                                await Helpers.showDeleteConfirmationDialog(
                                    context: context,
                                    title: AppLocalizations.of(context)!
                                        .removeExercise,
                                    content: AppLocalizations.of(context)!
                                        .removeExerciseConfirmation,
                                    confirmText:
                                        AppLocalizations.of(context)!.remove,
                                    isNegative: true);
                            if (shouldDelete == true) {
                              // ignore: use_build_context_synchronously
                              context
                                  .read<WorkoutBuilderBloc>()
                                  .add(RemoveAvailableExercise(exercise));
                            }
                          }
                        : null,
                    showDeleteIcon: exercise.isCustom,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
