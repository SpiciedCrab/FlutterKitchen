// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mealItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicMealItem _$BasicMealItemFromJson(Map<String, dynamic> json) {
  return BasicMealItem(
      json['objectId'] as String,
      json['name'] as String,
      json['remark'] as String,
      (json['capacity'] as num).toDouble(),
      json['deleted'] as bool);
}

Map<String, dynamic> _$BasicMealItemToJson(BasicMealItem instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'remark': instance.remark,
      'capacity': instance.capacity,
      'deleted': instance.deleted
    };
