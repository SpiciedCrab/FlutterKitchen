import 'package:flutter/material.dart';
import 'package:fatten_app/services/mealListService.dart';
import 'package:fatten_app/Models/mealItem.dart';
import 'package:fatten_app/fattenThemes.dart';
import 'package:fatten_app/tools/ensureVisible.dart';
import 'package:fatten_app/progressAwait.dart';
import 'dart:async';

class MealEditView extends StatefulWidget {

  BasicMealItem meal;

  MealEditView(this.meal);

  @override
  createState() => new MealEditViewState();
}


class MealEditViewState extends State<MealEditView> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode _remarkNode = new FocusNode();


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remarkField = new EnsureVisibleWhenFocused(
      focusNode: _remarkNode,
      child: new TextField(style: TextThemes.inputStyle ,
          maxLines: 50,
          onChanged: (String value){
            widget.meal.remark = value;
          },
          controller: TextEditingController.fromValue(TextEditingValue(text: widget.meal.remark ?? "",
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: (widget.meal.remark ?? "").length)))),
          decoration: const InputDecoration(
              hintText: '还需要说点啥',
              fillColor: Colors.blue
          )),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.check), onPressed: (){
            _formKey.currentState.save();
            ShowAwait.buildProgressingWithKey(_scaffoldKey,
                MealListService.updateMeal(widget.meal)
                    .then((value) => 1)
                    .then((value){
                  Navigator.of(context).pop(value);
            }));
          })
        ],
          title: new Text("我的肉肉")),

      body: new Container(
       child: new Form(
           key: _formKey,
           child: new SingleChildScrollView(
               child: new Column(
                 children: <Widget>[
                   new Row(
                     children: <Widget>[
                       new Expanded(
                         child: new Padding(
                           padding: const EdgeInsets.only(left: Margins.normal, top: Margins.normal, bottom: 5.0, right: Margins.normal),
                           child: new TextField(style: TextThemes.highlightStyle ,
                               onChanged: (String value){
                                  widget.meal.name = value;
                               },
                               controller: TextEditingController.fromValue(TextEditingValue(text: widget.meal.name,
                                   selection: TextSelection.fromPosition(TextPosition(
                                       affinity: TextAffinity.downstream,
                                       offset: widget.meal.name.length)))),
                               decoration: const InputDecoration(
                                   hintText: '什么肉啦',
                                   fillColor: Colors.blue
                               )),
                         ),
                       )
                     ],
                   ),
                   new Row(
                     children: <Widget>[
                       new Expanded(
                         child: new Padding(
                           padding: const EdgeInsets.only(left: Margins.normal, top: 0.0, bottom: Margins.normal, right: 150.0),
                           child: new TextField(style: new TextStyle(
                               fontSize: 48.0,
                               color: Colors.lightBlue,
                               fontWeight: FontWeight.normal,
                           ) ,
                               onChanged: (String value){
                                 widget.meal.capacity = double.parse(value);
                               },
                               keyboardType: TextInputType.number,
                               controller: TextEditingController.fromValue(TextEditingValue(text: widget.meal.capacity.toString(),
                                   selection: TextSelection.fromPosition(TextPosition(
                                       affinity: TextAffinity.downstream,
                                       offset: widget.meal.capacity.toString().length)))),
                               decoration: InputDecoration(
                                 hintText: '还剩0.0',
                                 suffix: new Text("克", style: TextThemes.highlightStyle),
                                 fillColor: Colors.blue,
                               )),
                         ),
                       ),
                     ],
                   ),
                   new Row(
                     children: <Widget>[
                       new Expanded(
                         child: new Container(
                             height: 150.0,
                             color: Colors.black12,
                             padding: const EdgeInsets.only(left: Margins.normal, top: 0.0, bottom: 5.0, right: Margins.normal),
                             child:  remarkField
                         ),
                       )
                     ],
                   ),
                 ],
               )
           )

        )
      )

    );
  }
}