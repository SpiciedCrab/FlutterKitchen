import 'package:flutter/material.dart';
import 'package:fatten_app/services/mealListService.dart';
import 'package:fatten_app/Models/mealItem.dart';
import 'package:fatten_app/fattenThemes.dart';
import 'package:fatten_app/routers.dart';
import 'package:fatten_app/progressAwait.dart';
import 'package:fatten_app/toast.dart';

class MealList extends StatefulWidget {

  @override
  createState() => new MealListState();
}


class MealListState extends State<MealList> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<BasicMealItem>>(
        future: MealListService.requestList(),
        builder: (csontext, snapshot) {
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

  Widget _buildRow(BasicMealItem item) {

    var cardRows = <Widget>[
      new Row(
        children: <Widget>[
          new Expanded(
              child: new Container(
                  padding: const EdgeInsets.only(left: Margins.normal, top: 15.0, bottom: 12.0),
                  child: new Container(
                    child: new Text(item.name, style: TextThemes.highlightStyle,),
                  )
              )
          ),
          new Container(
              child: new Container(
                color: item.capacity == 0 ? Colors.red : Colors.lightBlue,
                  padding: const EdgeInsets.only(left: Margins.normal, top: Margins.min, bottom: Margins.min, right: Margins.normal),
                  child: new Container(
                    child: new Text(item.capacity.toString() + " g", style: TextThemes.lightHighlightStyle,),
                  )
              )
          ),
        ],
      ),
    ];

    if(item.remark != null && item.remark.isNotEmpty) {
      final remarkRow = new Row(
        children: <Widget>[

          new Expanded(
              child: new Container(
                  padding: const EdgeInsets.only(left: Margins.normal, top: 0.0, bottom: Margins.normal, right: Margins.normal),
                  child: new Container(
                    child: new Text(item.remark ?? "", style: TextThemes.contentStyle, maxLines: 99,),
                  )
              )
          )
        ],
      );
      cardRows.add(remarkRow);
    }

    final buttonsRow = new Row(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(bottom: Margins.min),
          width: 80.0,
          child: new FlatButton(onPressed: (){
            Future nav = Navigator.of(context).push(Routers.mealEditPage(item));
            nav.then((value) {
              setState(() {

              });
            });
          }, child: new Text("加肉啦", style: new TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold),),
            padding: const EdgeInsets.only(left: 0.0, top: Margins.min,bottom: Margins.min, right: 0.0),),
        ),
        new Container(
          padding: const EdgeInsets.only(bottom: Margins.min),
          child: new FlatButton(onPressed: (){
            ShowAwait.buildProgressing(context,
                MealListService.deleteMeal(item)
                    .then((value) => 1)
                    .then((value){
                  Toasts.showMessage(context, "删除成功");
                  setState(() {

                  });

                }));
          }, child: new Text("这个不要了" ,style: new TextStyle(color: Colors.grey, fontSize: 16.0),),
            padding: const EdgeInsets.only(left: Margins.min, top: Margins.min,bottom: Margins.min, right: Margins.min),),
        ),
      ],
    );

    cardRows.add(buttonsRow);

    final card = new Card(
      child: Container(
        child: new Column(
          children: cardRows
        ),
      ),
    );


    return new Container(
      padding: CardThemes.cardPadding,
      child: card,
    );


  }
}

