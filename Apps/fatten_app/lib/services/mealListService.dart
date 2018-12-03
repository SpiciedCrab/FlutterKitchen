import 'package:fatten_app/services/serviceCetner.dart';
import 'package:fatten_app/Models/mealItem.dart';
import 'dart:async';
import 'dart:convert';

class MealListService {
  static Future<List<BasicMealItem>> requestList() {
    final url = "https://gwc5lncu.api.lncld.net/1.1/classes/Meal";
    return ServiceCenter.request(url, null, RequestMethod.get).then((value) => MealListService._mapToMeal(value));
  }

  static List<BasicMealItem> _mapToMeal(Map data) {
    final List<Map<dynamic,dynamic>> list = data["results"].cast<Map<dynamic,dynamic>>();
    return list.map((value) => BasicMealItem.fromJson(value)).where((value) => !value.deleted).toList();
  }

  static Future<bool> updateMeal(BasicMealItem meal) {

    if(meal.objectId.isEmpty) {
      final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Meal";
      return ServiceCenter.request(updateUrl, meal.toJson(), RequestMethod.post).then((value) => true);
    } else {
      final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Meal/${meal.objectId}";
      return ServiceCenter.request(updateUrl, meal.toJson(), RequestMethod.put).then((value) => true);
    }

  }

  static Future<bool> deleteMeal(BasicMealItem meal) {
    final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Meal/${meal.objectId}";
    meal.deleted = true;
    return ServiceCenter.request(updateUrl, meal.toJson(), RequestMethod.put).then((value) => true);
  }
}