import 'package:flutter/material.dart';
import 'package:fatten_app/meals/mealListView.dart';
import 'package:fatten_app/routers.dart';
import 'package:fatten_app/Models/mealItem.dart';
import 'package:fatten_app/fattenThemes.dart';

class MealPage extends StatefulWidget {

  MealPage({Key key}) : super(key: key);

  @override
  createState() => new MealPageState();
}


class MealPageState extends State<MealPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold (
        appBar: new AppBar(
            title: new Text("冰箱快空了 T_T"),
            actions: <Widget>[
        new IconButton(icon: Icon(Icons.add), onPressed: (){
          Future nav = Navigator.of(context).push(Routers.mealEditPage(new BasicMealItem("", "", "", 0.0, false)));
          nav.then((value) {
            setState(() {

            });
          });
     })]),
      body: new Padding(padding: const EdgeInsets.only(bottom: Margins.normal)
        ,child: new MealList(),),
    );
  }

}

