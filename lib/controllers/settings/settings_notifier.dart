import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/models/settings/app_settings_model.dart';

class SettingsNotifier extends ChangeNotifier {
  final Box<AppSettingsModel> box;
  late AppSettingsModel _settings;

  AppSettingsModel get settings => _settings;
  ThemeMode get themeMode => _settings.themeMode;
  String get currentLocale => _settings.languageCode;

  SettingsNotifier(this.box) {
    _settings = box.get('settings') ?? AppSettingsModel();
  }

  void updateThemeMode(int index) {
    _settings = _settings.copyWith(themeModeIndex: index);
    _save();
  }

  void updatePreferredUnit(String unit) {
    _settings = _settings.copyWith(preferredUnit: unit);
    _save();
  }

  void updateDefaultRestBetweenSets(int seconds) {
    _settings = _settings.copyWith(defaultRestBetweenSets: seconds);
    _save();
  }

  void updateDefaultRestBetweenExercises(int seconds) {
    _settings = _settings.copyWith(defaultRestBetweenExercises: seconds);
    _save();
  }

  void resetToDefaults() {
    _settings = AppSettingsModel();
    _save();
  }

  void _save() {
    box.put('settings', _settings);
    notifyListeners();
  }

  void updateDefaultRepsAndSets(int reps, int sets) {
    _settings = _settings.copyWith(defaultReps: reps, defaultSets: sets);
    _save();
  }

  void updateLanguage(String languageCode) {
    _settings = _settings.copyWith(languageCode: languageCode);
    _save();
  }
}
