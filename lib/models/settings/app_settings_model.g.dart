// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsModelAdapter extends TypeAdapter<AppSettingsModel> {
  @override
  final int typeId = 9;

  @override
  AppSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettingsModel(
      defaultRestBetweenSets: fields[0] as int,
      defaultRestBetweenExercises: fields[1] as int,
      themeModeIndex: fields[2] as int,
      preferredUnit: fields[3] as String,
      defaultReps: fields[4] as int,
      defaultSets: fields[5] as int,
      languageCode: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettingsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.defaultRestBetweenSets)
      ..writeByte(1)
      ..write(obj.defaultRestBetweenExercises)
      ..writeByte(2)
      ..write(obj.themeModeIndex)
      ..writeByte(3)
      ..write(obj.preferredUnit)
      ..writeByte(4)
      ..write(obj.defaultReps)
      ..writeByte(5)
      ..write(obj.defaultSets)
      ..writeByte(6)
      ..write(obj.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
