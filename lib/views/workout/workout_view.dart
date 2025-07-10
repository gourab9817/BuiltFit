import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_bloc.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_event.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:notoro/views/workout/widgets/new_exercise_button.dart';
import 'package:notoro/views/workout/widgets/new_workout_button.dart';
import 'package:notoro/views/workout/workout_detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/common/widgets/empty_state_widget.dart';
import 'new_workout_view.dart';
import 'widgets/workout_card.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutBox = Hive.box<WorkoutModel>('workouts');
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.fitness_center_outlined,
        title: AppLocalizations.of(context)!.workout,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          children: [
            NewExerciseButton(),
            NewWorkoutButton(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewWorkoutView(),
                  ));
            }),
            const SizedBox(height: 20),
            HeaderDivider(text: AppLocalizations.of(context)!.yourWorkouts),
            const SizedBox(height: 20),
            ValueListenableBuilder<Box<WorkoutModel>>(
              valueListenable: workoutBox.listenable(),
              builder: (context, box, _) {
                final workouts = box.values.toList().reversed.toList();

                if (workouts.isEmpty) {
                  return EmptyStateWidget(
                    title: AppLocalizations.of(context)!.noWorkoutsTitle,
                    subtitle: AppLocalizations.of(context)!.noWorkoutsSubtitle,
                  );
                }

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...workouts.map((workout) {
                          return WorkoutCard(
                            workout: workout,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => WorkoutDetailBloc(
                                        Hive.box<WorkoutModel>('workouts'))
                                      ..add(LoadAvailableExercisesDetails(
                                          context))
                                      ..add(LoadWorkoutDetail(
                                          workout.key as int)),
                                    child: const WorkoutDetailView(),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
