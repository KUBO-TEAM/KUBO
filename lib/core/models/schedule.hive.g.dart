// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleHiveAdapter extends TypeAdapter<ScheduleHive> {
  @override
  final int typeId = 0;

  @override
  ScheduleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleHive(
      recipeId: fields[0] as String,
      recipeName: fields[1] as String,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      color: fields[4] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.recipeId)
      ..writeByte(1)
      ..write(obj.recipeName)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
