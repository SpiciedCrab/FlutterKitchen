import 'package:fatten_app/Models/dailyItem.dart';

class MenuItem {
  int weekDay = 1;
  bool isSelected = false;
  List<BasicDailyItem> dailys = [];


  MenuItem(this.weekDay, this.dailys) {

  }
}