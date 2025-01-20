// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cartmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCartmodelAdapter extends TypeAdapter<HiveCartmodel> {
  @override
  final int typeId = 1;

  @override
  HiveCartmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCartmodel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as double,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCartmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.totalValue)
      ..writeByte(5)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
