// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryModelAdapter extends TypeAdapter<HistoryModel> {
  @override
  final int typeId = 7;

  @override
  HistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryModel(
      workoutName: fields[0] as String,
      exercises: (fields[1] as List).cast<ExerciseTrainingModel>(),
      date: fields[2] as DateTime,
      duration: fields[3] as Duration,
      wasAbandoned: fields[4] as bool,
      interruptedExerciseIndex: fields[5] as int?,
      interruptedSetIndex: fields[6] as int?,
      setDurations: (fields[7] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as int, (v as List).cast<Duration>())),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.workoutName)
      ..writeByte(1)
      ..write(obj.exercises)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.wasAbandoned)
      ..writeByte(5)
      ..write(obj.interruptedExerciseIndex)
      ..writeByte(6)
      ..write(obj.interruptedSetIndex)
      ..writeByte(7)
      ..write(obj.setDurations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
