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
      recipeName: fields[0] as String,
      scheduledDay: fields[1] as String,
      startingTime: fields[2] as String,
      endingTime: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.recipeName)
      ..writeByte(1)
      ..write(obj.scheduledDay)
      ..writeByte(2)
      ..write(obj.startingTime)
      ..writeByte(3)
      ..write(obj.endingTime);
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
