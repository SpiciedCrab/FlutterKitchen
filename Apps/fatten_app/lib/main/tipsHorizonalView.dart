import 'package:flutter/material.dart';


class TipHorizonalView extends StatefulWidget {

  List<String> tips;

  TipHorizonalView(this.tips);

  @override
  createState() => new TipHorizonalViewState(tips);
}


class TipHorizonalViewState extends State<TipHorizonalView> {

  List<String> tips;

  TipHorizonalViewState(this.tips);

  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 30.0,
      child: new Row(
        children: <Widget>[
          new Expanded(child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tips.length,
              itemBuilder:(crx , i){
                return _buildRow(tips[i]);
              }))
        ],
      ),
    );

  }

  Widget _buildRow(String item) {
    return new Container(padding: EdgeInsets.only(left: 0.0 , right: 5.0),
        child: new Text((item), style: new TextStyle(
          fontSize: 12.0,
          color: Colors.lightBlue,
      ),));
  }
}

