// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:notoro/views/workout/widgets/add_exercise_dialog.dart';
import 'package:notoro/views/workout/widgets/selected_excercises.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/available_exercises.dart';

class NewWorkoutView extends StatelessWidget {
  const NewWorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutBuilderBloc>(
      create: (_) => WorkoutBuilderBloc()..add(LoadAvailableExercises(context)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonAppbar(
          title: AppLocalizations.of(context)!.newWorkout,
          actions: [
            BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    final name =
                        context.read<WorkoutBuilderBloc>().state.workoutName;
                    final box = Hive.box<WorkoutModel>('workouts');
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackbar.show(
                          context: context,
                          message:
                              AppLocalizations.of(context)!.workoutNameEmpty,
                        ),
                      );
                      return;
                    }
                    final bloc = context.read<WorkoutBuilderBloc>();
                    final exercises = bloc.state.selectedExercises;
                    if (exercises.isEmpty) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackbar.show(
                          context: context,
                          message: AppLocalizations.of(context)!.addOneExercise,
                        ),
                      );
                      return;
                    }

                    final existingWorkout = box.values.firstWhere(
                      (workout) =>
                          workout.name.trim().toLowerCase() ==
                          name.trim().toLowerCase(),
                      orElse: () => WorkoutModel(name: '', exercises: []),
                    );

                    if (existingWorkout.name.trim() != '' ||
                        existingWorkout.exercises.isNotEmpty) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackbar.show(
                          context: context,
                          message: AppLocalizations.of(context)!
                              .workoutAlreadyExists,
                        ),
                      );
                      return;
                    }

                    final newWorkout = WorkoutModel(
                      name: name,
                      exercises: exercises,
                    );
                    await box.add(newWorkout);

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar.show(
                        context: context,
                        message: AppLocalizations.of(context)!.workoutCreated,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check, size: 30),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) =>
                        BlocProvider.of<WorkoutBuilderBloc>(context)
                            .add(UpdateWorkoutName(value.trim())),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.workoutName,
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 50,
                  );
                },
              ),
              const SizedBox(height: 20),
              HeaderDivider(text: AppLocalizations.of(context)!.exercises),
              const SizedBox(height: 20),
              Expanded(child: SelectedExercises()),
              const SizedBox(height: 20),
              BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
                builder: (context, state) {
                  return HeaderDivider(
                    text: AppLocalizations.of(context)!.availableExercises,
                    actionButton: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              AddExerciseDialog(parentContext: context),
                        );
                      },
                      icon: Icon(Icons.add,
                          size: 30,
                          color: Theme.of(context).colorScheme.onPrimary),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AvailableExercises(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
