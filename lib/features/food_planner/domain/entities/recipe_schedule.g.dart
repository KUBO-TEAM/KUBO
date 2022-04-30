// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeScheduleAdapter extends TypeAdapter<RecipeSchedule> {
  @override
  final int typeId = 0;

  @override
  RecipeSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeSchedule(
      recipeId: fields[0] as String,
      recipeName: fields[1] as String,
      start: fields[2] as DateTime,
      end: fields[3] as DateTime,
      color: fields[4] as Color,
      isAllDay: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeSchedule obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.recipeId)
      ..writeByte(1)
      ..write(obj.recipeName)
      ..writeByte(2)
      ..write(obj.start)
      ..writeByte(3)
      ..write(obj.end)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.isAllDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
