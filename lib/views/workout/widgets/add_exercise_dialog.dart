import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/workout/body_part.dart';

class AddExerciseDialog extends StatefulWidget {
  final BuildContext parentContext;
  final bool? showSnackbar;
  const AddExerciseDialog(
      {super.key, required this.parentContext, this.showSnackbar = false});

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final TextEditingController nameController = TextEditingController();
  final Set<BodyPart> selectedParts = {};

  void togglePart(BodyPart part) {
    setState(() {
      if (selectedParts.contains(part)) {
        selectedParts.remove(part);
      } else {
        selectedParts.add(part);
      }
    });
  }

  void submit() {
    final name = nameController.text.trim();
    final parts = selectedParts.toList();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(
            context: context,
            message: AppLocalizations.of(context)!.exerciseNameEmpty),
      );
      return;
    }
    if (parts.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(
            context: context,
            message: AppLocalizations.of(context)!.addOnePart),
      );
      return;
    }

    final existing = BlocProvider.of<WorkoutBuilderBloc>(widget.parentContext)
        .state
        .availableExercises;

    final nameAlreadyExists = existing.any(
      (exercise) => exercise.name.toLowerCase() == name.toLowerCase(),
    );

    if (nameAlreadyExists) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(
          context: context,
          message: AppLocalizations.of(context)!.exerciseAlreadyExists,
        ),
      );
      return;
    }

    final newExercise = ExerciseModel(
      name: name,
      bodyParts: parts,
      assetImagePath: '',
      isCustom: true,
    );

    BlocProvider.of<WorkoutBuilderBloc>(widget.parentContext)
        .add(AddAvailableExercise(newExercise));

    if (widget.showSnackbar == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar.show(
            context: context,
            message: AppLocalizations.of(context)!.exerciseAdded),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addExercise),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              controller: nameController,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.exerciseName,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 4,
              runSpacing: -2,
              children: BodyPart.values
                  .map((part) => FilterChip(
                        label: Text(Helpers.mapBodyPartToName(part, context)),
                        checkmarkColor: Colors.white,
                        avatar: Helpers.buildPartImage(part, 60, 60),
                        selected: selectedParts.contains(part),
                        onSelected: (_) => togglePart(part),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: submit,
          child: Text(AppLocalizations.of(context)!.add),
        ),
      ],
    );
  }
}
