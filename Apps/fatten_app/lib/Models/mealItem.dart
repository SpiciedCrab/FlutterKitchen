import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mealItem.g.dart';
@JsonSerializable(nullable: false)
class BasicMealItem {
  final String objectId;
  String name = "";
  String remark = "";
  double capacity = 0.0;
  bool deleted = false;

  BasicMealItem(this.objectId, this.name , this.remark , this.capacity, this.deleted);

  static BasicMealItem fromJson(json) => _$BasicMealItemFromJson(json);

  Map<dynamic, dynamic> toJson() => _$BasicMealItemToJson(this);
}