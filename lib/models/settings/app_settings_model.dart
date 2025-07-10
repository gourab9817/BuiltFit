import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'app_settings_model.g.dart';

@HiveType(typeId: 9)
class AppSettingsModel extends HiveObject {
  @HiveField(0)
  final int defaultRestBetweenSets;

  @HiveField(1)
  final int defaultRestBetweenExercises;

  @HiveField(2)
  final int themeModeIndex;

  @HiveField(3)
  final String preferredUnit;

  @HiveField(4)
  final int defaultReps;

  @HiveField(5)
  final int defaultSets;

  @HiveField(6)
  final String languageCode;

  AppSettingsModel({
    this.defaultRestBetweenSets = 90,
    this.defaultRestBetweenExercises = 120,
    this.themeModeIndex = 0,
    this.preferredUnit = 'kg',
    this.defaultReps = 8,
    this.defaultSets = 4,
    this.languageCode = 'en',
  });

  ThemeMode get themeMode {
    switch (themeModeIndex) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  AppSettingsModel copyWith({
    int? defaultRestBetweenSets,
    int? defaultRestBetweenExercises,
    int? themeModeIndex,
    String? preferredUnit,
    int? defaultReps,
    int? defaultSets,
    String? languageCode,
  }) {
    return AppSettingsModel(
      defaultRestBetweenSets:
          defaultRestBetweenSets ?? this.defaultRestBetweenSets,
      defaultRestBetweenExercises:
          defaultRestBetweenExercises ?? this.defaultRestBetweenExercises,
      themeModeIndex: themeModeIndex ?? this.themeModeIndex,
      preferredUnit: preferredUnit ?? this.preferredUnit,
      defaultReps: defaultReps ?? this.defaultReps,
      defaultSets: defaultSets ?? this.defaultSets,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
