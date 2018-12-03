import 'package:meta/meta.dart';
import 'package:fatten_app/services/serviceCetner.dart';
import 'mealItem.dart';

class BasicDailyItem {
  final String itemId;
  final DateTime scheduledTime;
  final String itemName = "sha";
  bool isFeed = false;
  String feedTime;
  String remarks;
  bool isCancelled = false;
  bool isMenu = false;

  List<String> nutritions = ["ss"];
  List<BasicMealItem> meals = [];

  bool operator ==(o) => o is BasicDailyItem && o.itemId == itemId;

  String get actionTitle {
    if(isFeed && !isCancelled) {
      return "已吃饱";
    } else if(isCancelled) {
      return "重新喂一次";
    } else {
      return "Feed me!";
    }
  }


  BasicDailyItem(this.itemId, this.scheduledTime , this.isFeed , this.feedTime, this.remarks, this.isCancelled, this.isMenu, this.meals);

  static BasicDailyItem fromJson(Map<dynamic, dynamic> json) {
    bool cancelled = json["isCancelled"];
    bool isMenu = json["isMenu"];
    bool feeded = json["isFeed"];
    String time = json["scheduledTime"];
    BasicMealItem meal = BasicMealItem.fromJson(json["meal"]);
    return new BasicDailyItem(json["objectId"],
        DateTime.parse(time),
        feeded,
        json["feedTime"],
        json["remarks"],
        cancelled,
        isMenu,
        [meal]);
  }

  Map<String, dynamic> toJson() {
    return {
      'objectId': itemId,
      'name': itemName,
      'isFeed': isFeed,
      'feedTime': feedTime,
      'scheduledTime': scheduledTime.toString(),
      'remarks': remarks,
      'isCancelled': isCancelled,
      'isMenu': isMenu
    };

  }
}