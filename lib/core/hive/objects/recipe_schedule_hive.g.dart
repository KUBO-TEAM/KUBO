// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_schedule_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeScheduleHiveAdapter extends TypeAdapter<RecipeScheduleHive> {
  @override
  final int typeId = 0;

  @override
  RecipeScheduleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeScheduleHive(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      displayPhoto: fields[3] as String,
      start: fields[4] as DateTime,
      end: fields[5] as DateTime,
      color: fields[6] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeScheduleHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.displayPhoto)
      ..writeByte(4)
      ..write(obj.start)
      ..writeByte(5)
      ..write(obj.end)
      ..writeByte(6)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeScheduleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
