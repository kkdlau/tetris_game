import 'package:flutter/material.dart';
import 'package:tetris_game/setting.dart';
import 'package:tetris_game/tetris_game.dart';

import 'badge.dart';

bool darkTheme = false;

class FrontPage extends StatefulWidget {
  FrontPage({Key key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    actions: <Widget>[
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Dismiss'),
                      )
                    ],
                    title: Text("How to Control?",
                        style: Theme.of(context).textTheme.headline),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "Generally, you can use bottom /right control panel to control the block. \nHowever, for PC users, you can also use WASD to control."),
                        Text("\nWASD control:\n",
                            style: Theme.of(context).textTheme.headline),
                        Text(
                            "A = move left, D = move right, W = rotate, S = drop"),
                      ],
                    ),
                  ));
            },
          ),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Setting(
                    darkTheme: darkTheme,
                  );
                }));
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Badge(expandedWidth: MediaQuery.of(context).size.width * 0.7),
            Column(
              children: <Widget>[
                Text(
                  'Select a difficulty to start:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Tetris(
                              width: 10,
                              height: 15,
                              gameSpeed: 700,
                              color: Colors.green[600],
                            );
                          }));
                        },
                        child: Text('Easy'),
                        color: Colors.green[600],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0))),
                    message: 'The slowest speed',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                  child: Tooltip(
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Tetris(
                              width: 10,
                              height: 15,
                              gameSpeed: 500,
                              color: Colors.indigo[900],
                            );
                          }));
                        },
                        child: Text('Middle'),
                        color: Colors.indigo[900],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0))),
                    message: 'Middle speed',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                  child: Tooltip(
                    message: 'The hardest mode! challenge yourself!',
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Tetris(
                              width: 10,
                              height: 15,
                              gameSpeed: 200,
                              color: Colors.pink[900],
                            );
                          }));
                        },
                        child: Text('Hard'),
                        color: Colors.pink[900],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0))),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
