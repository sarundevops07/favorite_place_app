// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePlaceModelAdapter extends TypeAdapter<HivePlaceModel> {
  @override
  final int typeId = 1;

  @override
  HivePlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePlaceModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      imagePath: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      address: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HivePlaceModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
