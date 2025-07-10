// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_part.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyPartAdapter extends TypeAdapter<BodyPart> {
  @override
  final int typeId = 2;

  @override
  BodyPart read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BodyPart.chest;
      case 1:
        return BodyPart.back;
      case 2:
        return BodyPart.legs;
      case 3:
        return BodyPart.arms;
      case 4:
        return BodyPart.shoulders;
      case 5:
        return BodyPart.abs;
      default:
        return BodyPart.chest;
    }
  }

  @override
  void write(BinaryWriter writer, BodyPart obj) {
    switch (obj) {
      case BodyPart.chest:
        writer.writeByte(0);
        break;
      case BodyPart.back:
        writer.writeByte(1);
        break;
      case BodyPart.legs:
        writer.writeByte(2);
        break;
      case BodyPart.arms:
        writer.writeByte(3);
        break;
      case BodyPart.shoulders:
        writer.writeByte(4);
        break;
      case BodyPart.abs:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyPartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
