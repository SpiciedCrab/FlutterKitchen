import 'package:flutter/material.dart';
import 'package:fatten_app/main/tipsHorizonalView.dart';
import 'package:fatten_app/Models/dailyItem.dart';
import 'package:fatten_app/fattenThemes.dart';
import 'package:fatten_app/services/dailyListService.dart';


class DailyItem extends StatefulWidget {

  final BasicDailyItem dailyModel;
  DailyItem(this.dailyModel);

  @override
  State<StatefulWidget> createState() => DailyItemState();
}

class DailyItemState extends State<DailyItem> {

  bool isLoading = false;

  List<Choice> choices = [];


  Widget buildButtonChild() {

    if (isLoading) {
      return new Container(padding: const EdgeInsets.all(5.0),
        child: CircularProgressIndicator(),
      );
    } else {
      return new Container(padding: const EdgeInsets.all(5.0),
        child: new Text
        (widget.dailyModel.actionTitle, style: new TextStyle(
          color: Colors.lightBlue,
            fontSize: 14.0, fontWeight: FontWeight.bold
          ),
      ));
    }
  }

  void _select(Choice choice) {
    setState(() { 
      choice.selected(widget.dailyModel);
    });
  }

  void setupPopupButtons() {
    choices.clear();

    final delayChoice = Choice(title: '喂晚了', callback: (BasicDailyItem item){
      print("Delay");
    });

    final abandonChoice = Choice(title: '不给吃了！', callback: (BasicDailyItem item){
      DailyListService.cancelDaily(item).then((result){

        setState(() {
          print("cancelled");
        });
      });
    });

    choices.add(delayChoice);
    choices.add(abandonChoice);
  }

  Widget buildPopup() {
    if(widget.dailyModel.isFeed) {
      return new Container(
        padding: const EdgeInsets.only(right: 20.0, top: 0.0 ,bottom: 0.0),
        child: new Text
          ("",
            style: new TextStyle(
              fontSize: 15.0,
            )),
      ) ;
    }

    if(widget.dailyModel.isCancelled) {
      return new Container(
        padding: const EdgeInsets.only(right: 20.0, top: 0.0 ,bottom: 0.0),
        child: new Text
          ("不吃了！",
            style: new TextStyle(
                fontSize: 15.0,
            )),
      ) ;
    } else {
      return new PopupMenuButton<Choice>(
        // overflow menu
        onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.map((Choice choice) {
            return new PopupMenuItem<Choice>(
              value: choice,
              child: new Text(choice.title),
            );
          }).toList();
        },);
    }
  }

  @override
  Widget build(BuildContext context) {

    setupPopupButtons();

    final button = new FlatButton(padding: const EdgeInsets.all(0.0),
        highlightColor: Colors.white,
        child: buildButtonChild() ,onPressed: () {
      setState((){
        this.isLoading = true;
      });

      DailyListService.updateDaily(widget.dailyModel).then((value){
        setState((){
          this.isLoading = false;
        });
      });
    });

    final item = new Container(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(child:
                new Container(
                  padding: const EdgeInsets.only(left: TextThemes.titleLeft, top: 20.0 ,bottom: 0.0),
                  child: new Text
                    (widget.dailyModel.feedTime,
                    style: TextThemes.titleStyle,
                  ),
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(left: 20.0, top: 15.0 ,bottom: 0.0),
                child: buildPopup()
              ),],
          ),
          new Divider(height: 20.0, color: Colors.lightBlue, indent: 20.0,),
          new Row(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(left: 20.0, top: 0.0 ,bottom: 0.0),
                child: new Text
                  (widget.dailyModel.itemName,
                  style: TextThemes.highlightStyle,
                ),
              ),
              new Expanded(
                  child: new Container(
                    padding: const EdgeInsets.only(left: 15.0, top: 10.0 ,bottom: 0.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          height: 30.0,
                          child: new TipHorizonalView(widget.dailyModel.nutritions),
                        ),
                      ],
                    ),
                  )
              ),

            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  padding: const EdgeInsets.only(left: 20.0, top: 0.0 ,bottom: 0.0, right: 20.0),
                  child: new Text
                    (widget.dailyModel.remarks,
                    maxLines: 99,
                    style: new TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey
                    ),
                  ),
                )
              )
            ],
          ),
          new Row(
//            crossAxisAlignment: CrossAxisAlignment.start ,
            children: <Widget>[
              new Expanded(child: new Row(children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(left: 20.0, top: 15.0 ,bottom: 20.0),
                  child: new Icon(Icons.timer, color: Colors.grey, size: 18.0,),
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 5.0, top: 15.0 ,bottom: 20.0),
                  child: new Text
                    ("还剩5小时",
                    style: new TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey
                    ),
                  ),
                ),
              ],)),
              new Container(
                padding: const EdgeInsets.only(left: 5.0, top: 15.0 ,bottom: 20.0, right: 15.0),
                child: button
              ),
            ],
          ),
        ],
      )
    );
    final contentArea = new Card(
//      margin: const EdgeInsets.only(left: 15.0, top: 7.5 , right: 15.0 , bottom: 7.5),
      child: item,
      color: widget.dailyModel.isCancelled ? Color.fromARGB(244, 244, 244, 244) : Colors.white,
    );

    final whole = new Container(
      padding: CardThemes.cardPadding,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          contentArea
        ],
      ),
    );
    return whole;
  }
}

class Choice {
  const Choice({ this.title , this.callback });
  final String title;

  final SelectChoice callback;

  void selected(BasicDailyItem item) {
    callback(item);
  }
}

typedef SelectChoice(BasicDailyItem item);

