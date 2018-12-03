import 'package:flutter/material.dart';
import 'package:fatten_app/meals/mealEditView.dart';
import 'package:fatten_app/Models/mealItem.dart';

class Routers {

  // 肉肉列表页
  static final String mealPage = "/meal";

  // 肉肉编辑页
  static MaterialPageRoute mealEditPage(BasicMealItem meal) => new MaterialPageRoute(builder: (_) {
    return new MealEditView(meal);
  });

  // 菜单列表页
  static final String menuPage = "/menu";
}