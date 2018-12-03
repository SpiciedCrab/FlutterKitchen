import 'package:flutter/material.dart';
import 'package:fatten_app/main/dailyListView.dart';
import 'package:fatten_app/routers.dart';
class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  createState() => new HomePageState();
}


class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Harly'),
      accountEmail: new Text('小火鸡'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage(''), radius: 35.0,),);

    return Scaffold (
      appBar: new AppBar(
        title: new Text("Fattened..?")),
      body: new DailyList(),
      drawer: Drawer(
      child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        userHeader , // 可在这里替换自定义的header
        ListTile(title: Text('我的冰箱'),
          leading: new Icon(Icons.free_breakfast, color: Colors.lightBlue,),
          onTap: () {
            Navigator.of(context).pushNamed(Routers.mealPage);
          },),
        ListTile(title: Text('我的食谱'),
          leading: new Icon(Icons.menu, color: Colors.lightBlue,),
          onTap: () {
            Navigator.of(context).pushNamed(Routers.menuPage);
          },),
        ListTile(title: Text('Item 3'),
          leading: new CircleAvatar(
            child: new Icon(Icons.list),),
          onTap: () {
            Navigator.pop(context);
          },),
      ],
    )));
  }

}

