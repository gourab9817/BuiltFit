// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_training_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseTrainingModelAdapter extends TypeAdapter<ExerciseTrainingModel> {
  @override
  final int typeId = 1;

  @override
  ExerciseTrainingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseTrainingModel(
      name: fields[0] as String,
      bodyParts: (fields[1] as List).cast<BodyPart>(),
      assetImagePath: fields[2] as String,
      sets: fields[3] as int,
      reps: (fields[4] as List).cast<int>(),
      weight: (fields[5] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseTrainingModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.bodyParts)
      ..writeByte(2)
      ..write(obj.assetImagePath)
      ..writeByte(3)
      ..write(obj.sets)
      ..writeByte(4)
      ..write(obj.reps)
      ..writeByte(5)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTrainingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
