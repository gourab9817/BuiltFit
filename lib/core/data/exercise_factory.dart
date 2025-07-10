import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/workout/body_part.dart';
import '../../models/workout/exercise_model.dart';

class ExerciseFactory {
  static List<ExerciseModel> getBaseExercises(BuildContext context) {
    return [
      ExerciseModel(
        name: AppLocalizations.of(context)!.benchPress,
        bodyParts: [BodyPart.chest, BodyPart.shoulders, BodyPart.arms],
        assetImagePath: 'assets/exercises/bench_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.deadlift,
        bodyParts: [BodyPart.back, BodyPart.legs],
        assetImagePath: 'assets/exercises/deadlift.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.legPressMachine,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/leg_press_machine.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.preacherCurl,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/preacher_curl.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.pushUp,
        bodyParts: [BodyPart.chest, BodyPart.arms, BodyPart.shoulders],
        assetImagePath: 'assets/exercises/push_up.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.crunch,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/exercises/crunch.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.shoulderPress,
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/exercises/shoulder_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.squat,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/squat.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.bentOverRow,
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/exercises/bent_over_row.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.pullUp,
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/exercises/pull_up.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.barbellCurl,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/barbell_curl.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.tricepsDips,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/triceps_dips.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.legExtension,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/leg_extension.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.legCurl,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/leg_curl.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.calfRaise,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/calf_raise.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.latPulldown,
        bodyParts: [BodyPart.back],
        assetImagePath: 'assets/exercises/lat_pulldown.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.chestFly,
        bodyParts: [BodyPart.chest],
        assetImagePath: 'assets/exercises/chest_fly.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.pecDeck,
        bodyParts: [BodyPart.chest],
        assetImagePath: 'assets/exercises/pec_deck.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.hammerCurl,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/hammer_curl.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.skullCrusher,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/skullcrusher.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.lateralRaise,
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/exercises/lateral_raise.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.frontRaise,
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/exercises/front_raise.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.plank,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/exercises/plank.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.bicycleCrunch,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/exercises/bicycle_crunch.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.mountainClimber,
        bodyParts: [BodyPart.abs, BodyPart.legs],
        assetImagePath: 'assets/exercises/mountain_climber.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.russianTwist,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/exercises/russian_twist.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.hipThrust,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/hip_thrust.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.facePull,
        bodyParts: [BodyPart.shoulders, BodyPart.back],
        assetImagePath: 'assets/exercises/face_pull.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.inclineBench,
        bodyParts: [BodyPart.chest, BodyPart.shoulders],
        assetImagePath: 'assets/exercises/incline_bench.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.reverseLunge,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/reverse_lunge.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.stepUp,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/step_up.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.cableCrossover,
        bodyParts: [BodyPart.chest],
        assetImagePath: 'assets/exercises/cable_crossover.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.shrug,
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/exercises/shrug.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.legPress,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/leg_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.gluteKickback,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/glute_kickback.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.abWheelRollout,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/exercises/ab_wheel.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.closeGripBench,
        bodyParts: [BodyPart.chest, BodyPart.arms],
        assetImagePath: 'assets/exercises/close_grip_bench.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.declineCrunch,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/exercises/decline_crunch.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.farmerWalk,
        bodyParts: [BodyPart.legs, BodyPart.arms, BodyPart.shoulders],
        assetImagePath: 'assets/exercises/farmer_walk.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.tBarRow,
        bodyParts: [BodyPart.back],
        assetImagePath: 'assets/exercises/tbar_row.png',
        isCustom: false,
      ),
    ];
  }
}
