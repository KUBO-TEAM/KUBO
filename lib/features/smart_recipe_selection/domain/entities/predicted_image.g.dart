// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predicted_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PredictedImageAdapter extends TypeAdapter<PredictedImage> {
  @override
  final int typeId = 6;

  @override
  PredictedImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PredictedImage(
      imageUrl: fields[1] as String,
      categories: (fields[3] as List).cast<Category>(),
      predictedAt: fields[22] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PredictedImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(22)
      ..write(obj.predictedAt)
      ..writeByte(3)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredictedImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
