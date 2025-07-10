import 'package:flutter_test/flutter_test.dart';
import 'package:notoro/models/settings/app_settings_model.dart';

void main() {
  group('AppSettingsModel', () {
    test('copyWith returns updated instance', () {
      final initial = AppSettingsModel();
      final updated = initial.copyWith(defaultRestBetweenSets: 60);

      expect(updated.defaultRestBetweenSets, 60);
      expect(updated.defaultRestBetweenExercises,
          initial.defaultRestBetweenExercises);
    });

    test('themeMode returns correct ThemeMode', () {
      final model = AppSettingsModel(themeModeIndex: 2);
      expect(model.themeMode.toString(), contains('dark'));
    });
  });
}
