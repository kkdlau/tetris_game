import 'package:flutter/material.dart';
import 'package:tetris_game/tetris_game.dart';

import 'front_page.dart';

class GameOverPage extends StatefulWidget {
  final int score;
  final int gameSpeed;
  final Color difficultyColor;
  GameOverPage({Key key, this.score, this.gameSpeed, this.difficultyColor})
      : super(key: key);

  @override
  _GameOverPageState createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(
                tag: 'score',
                child: Material(
                    color: Colors.transparent,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text('Score: ' + widget.score.toString(),
                          style: Theme.of(context).textTheme.headline),
                    ))),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return FrontPage();
                      }));
                    },
                    color: Colors.red[400],
                    textColor: Colors.white,
                    child: Text('Back to front page'),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Tetris(
                          width: 10,
                          height: 15,
                          gameSpeed: widget.gameSpeed,
                          color: widget.difficultyColor,
                        );
                      }));
                    },
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text('Start a new game'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
