import 'package:fatten_app/services/serviceCetner.dart';
import 'package:fatten_app/Models/dailyItem.dart';
import 'package:fatten_app/Models/menuItem.dart';
import 'dart:async';
import 'dart:core';
import 'package:collection/collection.dart';

class MenuService {
  static Future<List<MenuItem>> requestList() {
    // where {"isMenu": true}
    final url = "https://gwc5lncu.api.lncld.net/1.1/classes/DailyMeal?where={\"isMenu\": true}&include=daily,meal";
    return ServiceCenter.request(url, null, RequestMethod.get)
        .then((value) => MenuService._mapAllToDaily(value))
        .then(MenuService.adjustMenus);
  }

  static List<BasicDailyItem> _mapAllToDaily(Map data) {
    final List<Map<dynamic,dynamic>> originalList = data["results"].cast<Map<dynamic,dynamic>>();
    final list = originalList.map((f){
      var newDic = f["daily"];
      newDic["meal"] = f["meal"];
      return newDic;
    });
    final originList = list.map((value) => BasicDailyItem.fromJson(value)).toList();
    final groupedDaily = groupBy(originList, (c)=>c);
    groupedDaily.keys.forEach((g){
      g.meals = groupedDaily[g];
    });

    return groupedDaily.keys;
  }


  static List<MenuItem> adjustMenus(List<BasicDailyItem> originalMenu){

    final groupedMenu = groupBy(originalMenu, (i) => i.scheduledTime.weekday);
    final menus = groupedMenu.keys.map((key) => MenuItem(key, groupedMenu[key])).toList();

    final orinalSet = menus.toSet();
    final weekNumSet = [1,2,3,4,5,6,7].toSet();
    final missingSet = weekNumSet.difference(orinalSet.map((value)=> value.weekDay).toSet());

    int compareDate(MenuItem f, MenuItem s) {
      return f.weekDay >= s.weekDay ? 1 : 0;
    }

    if(missingSet.isEmpty) {
      menus.sort(compareDate);
      return menus.toList();
    } else {
      final missingDates = missingSet.map((c)=> MenuItem(c, []));
      menus.addAll(missingDates);
      menus.sort(compareDate);
      return menus.toList();
    }
  }

  static DateTime _newDateOnWeekDay(int date) {
    return DateTime.now().add(Duration(days: date - DateTime.now().weekday));
  }

  static List<BasicDailyItem> _mapToDaily(Map data) {
    final List<Map<dynamic,dynamic>> list = data["results"].cast<Map<dynamic,dynamic>>();
    return list.map((value) => BasicDailyItem.fromJson(value)).toList();
  }

  static Future<bool> updateDaily(BasicDailyItem daily) {

    if(daily.isCancelled) {
      daily.isCancelled = false;
    } else {
      daily.isFeed = true;
    }
    final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Daily/${daily.itemId}";
    return ServiceCenter.request(updateUrl, daily.toJson(), RequestMethod.put).then((value) => true);
  }

  static Future<bool> cancelDaily(BasicDailyItem daily) {
    daily.isCancelled = true;
    final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Daily/${daily.itemId}";
    return ServiceCenter.request(updateUrl, daily.toJson(), RequestMethod.put).then((value) => true);
  }
}


class DailyListService {
  static Future<List<BasicDailyItem>> requestList() {
    final url = "https://gwc5lncu.api.lncld.net/1.1/classes/Daily";
    return ServiceCenter.request(url, null, RequestMethod.get).then((value) => DailyListService._mapToDaily(value));
  }


  static List<BasicDailyItem> _mapToDaily(Map data) {
    final List<Map<dynamic,dynamic>> list = data["results"].cast<Map<dynamic,dynamic>>();
    return list.map((value) => BasicDailyItem.fromJson(value)).toList();
  }

  static Future<bool> updateDaily(BasicDailyItem daily) {

    if(daily.isCancelled) {
      daily.isCancelled = false;
    } else {
      daily.isFeed = true;
    }
    final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Daily/${daily.itemId}";
    return ServiceCenter.request(updateUrl, daily.toJson(), RequestMethod.put).then((value) => true);
  }

  static Future<bool> cancelDaily(BasicDailyItem daily) {
    daily.isCancelled = true;
    final updateUrl = "https://gwc5lncu.api.lncld.net/1.1/classes/Daily/${daily.itemId}";
    return ServiceCenter.request(updateUrl, daily.toJson(), RequestMethod.put).then((value) => true);
  }
}
