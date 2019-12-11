import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final Function moveLeft;
  final Function moveRight;
  final Function drop;
  final Function rotate;

  const ControlPanel(
      {Key key, this.moveLeft, this.moveRight, this.drop, this.rotate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(Icons.arrow_left),
                  onPressed: moveLeft),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(Icons.rotate_90_degrees_ccw),
                  onPressed: rotate,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Icon(Icons.arrow_right),
                onPressed: moveRight,
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(Icons.arrow_downward),
                  onPressed: drop,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
