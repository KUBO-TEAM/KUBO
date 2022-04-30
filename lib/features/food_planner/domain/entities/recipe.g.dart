// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 2;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      course: fields[3] as String,
      cuisine: fields[4] as String,
      prepTime: fields[5] as int,
      cookTime: fields[6] as int,
      servings: fields[7] as int,
      reference: fields[8] as String,
      displayPhoto: fields[9] as String,
      categories: (fields[10] as List).cast<String>(),
      ingredients: (fields[11] as List).cast<Ingredient>(),
      instructions: (fields[12] as List).cast<String>(),
      createdAt: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.course)
      ..writeByte(4)
      ..write(obj.cuisine)
      ..writeByte(5)
      ..write(obj.prepTime)
      ..writeByte(6)
      ..write(obj.cookTime)
      ..writeByte(7)
      ..write(obj.servings)
      ..writeByte(8)
      ..write(obj.reference)
      ..writeByte(9)
      ..write(obj.displayPhoto)
      ..writeByte(10)
      ..write(obj.categories)
      ..writeByte(11)
      ..write(obj.ingredients)
      ..writeByte(12)
      ..write(obj.instructions)
      ..writeByte(13)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
