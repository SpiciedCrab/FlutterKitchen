import 'package:flutter/material.dart';
import 'package:fatten_app/Models/dailyItem.dart';
import 'package:fatten_app/Models/menuItem.dart';
import 'package:fatten_app/fattenThemes.dart';
import 'package:fatten_app/tools/ensureVisible.dart';
import 'package:fatten_app/progressAwait.dart';
import 'package:fatten_app/services/dailyListService.dart';
import 'package:fatten_app/formats.dart';
import 'dart:async';

class MenuHome extends StatefulWidget {

  @override
  createState() => new MenuHomeState();
}


class MenuHomeState extends State<MenuHome> {

  List<MenuItem> menus = [];

  bool isLoading = false;

  MenuItem selectedMenu;

  @override
  void initState() {
    // TODO: implement initState

    _fetchMenus();
    super.initState();
  }

  void _fetchMenus(){
    isLoading = true;
    MenuService.requestList().then((m){
      isLoading = false;
      setState(() {
        menus = m;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if(!isLoading){
      content = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: menus.length,
            itemBuilder:(crx , i){
              final item = menus[i];

              return new Container(
                  width: MediaQuery.of(context).size.width / menus.length,
                  padding: EdgeInsets.all(Margins.min),
                  child: new Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                          color: Colors.transparent,
                          width: 0.0,
                          style: BorderStyle.solid
                      ),
                      color: item.isSelected? Colors.blue : Colors.transparent,
                      borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
                    ),
                    child: new FlatButton(onPressed: (){
                      selectedMenu = menus[i];
                      setState(() {
                        menus.forEach((c) => c.isSelected = false);
                        menus[i].isSelected = true;

                      });

                    }, child: new Text(item.weekDay.toString(),
                      style: item.isSelected? TextThemes.lightHighlightStyle : TextThemes.contentStyle,
                      textAlign: TextAlign.center,),
                    ))
              );
            }) ;
      } else {
      content = new Center(child: new CircularProgressIndicator());
    }

    Widget scaContent;
    if(selectedMenu != null) {
      scaContent = new Container(
        child: new ListView.builder(itemCount: selectedMenu.dailys.length,
            itemBuilder: (c,r) {
              final item = selectedMenu.dailys[r];
              return new Container(
                padding: EdgeInsets.all(Margins.normal),
                child: new Card(
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.all(Margins.normal),
                          child: new Row(
                            children: <Widget>[
                              new Icon(Icons.timer, size: 20.0,),
                              new Padding(padding: EdgeInsets.only(left: Margins.min),
                                child: new Text(FattenFormats.formatDate(item.scheduledTime) , style: TextThemes.highlightStyle,),
                              )
                            ],
                          )
                      )
                    ],
                  )),
                );
            }),
      );
    } else {
      scaContent = new Center(
        child: new Text("选一天吧"),
      );
    }
    return Scaffold (
      floatingActionButton: new FloatingActionButton(onPressed: (){

      }, child: new Icon(Icons.add),
      backgroundColor: Colors.blue,),
      appBar: new AppBar(
          title: new Text("我的菜单"),
          elevation: 0.0,
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.add), onPressed: (){

            })]),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new Container(
              height: 50.0,
              child: content,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  boxShadow: [new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    spreadRadius: 4.0
                  ),]
              ),
            )
          ),
          new Expanded(child: scaContent)
        ],
      )
    );
  }
}