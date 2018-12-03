import 'package:flutter/material.dart';
import 'package:fatten_app/main/dailyListItem.dart';
import 'package:fatten_app/Models/dailyItem.dart';
import 'package:fatten_app/services/dailyListService.dart';

class DailyList extends StatefulWidget {

  @override
  createState() => new DailyListState();
}


class DailyListState extends State<DailyList> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<BasicDailyItem>>(
      future: DailyListService.requestList(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder:(crx , i){
                return _buildRow(snapshot.data[i]);
              });
        }
        else {
          return new Center(
            child: new CircularProgressIndicator(),
          ) ;
        }
      }

    );
  }

  Widget _buildRow(BasicDailyItem item) {

    return new DailyItem(item);
  }
}

