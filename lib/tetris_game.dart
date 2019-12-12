import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tetris_game/scale_route.dart';
import 'block_data.dart';
import 'control_panel.dart';
import 'dics.dart';
import 'game_field.dart';
import 'game_over.dart';

class Tetris extends StatefulWidget {
  final int width;
  final int height;
  final int gameSpeed;
  final Color color;
  Tetris({Key key, this.width, this.height, this.gameSpeed, this.color})
      : super(key: key);

  @override
  _TetrisState createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  Block activeBlock;
  List<List<Color>> mapData = [];
  List<Color> emtpyRow = [];
  Timer gameLoopTimer;
  int score = 0;

  @override
  void initState() {
    super.initState();
    //initialize game map data
    for (int r = 0; r < widget.height; r++) {
      mapData.add([]);
      for (int c = 0; c < widget.width; c++) {
        mapData[r].add(null);
      }
    }
    emtpyRow = List.from(mapData[0]);
    //game loop
    gameLoopTimer =
        Timer.periodic(Duration(milliseconds: widget.gameSpeed), gameLoop);
    //keyboard support
    document.addEventListener('keypress', keybaordHandling);
  }

  void gameLoop(Timer timer) {
    if (activeBlock == null) {
      makeNewBlock();
      if (!isValidBlock(activeBlock.type, activeBlock.row, activeBlock.col,
          activeBlock.orientation)) {
        //no free spaces, game over
        activeBlock = null;
        gameLoopTimer.cancel();
        document.removeEventListener('keypress', keybaordHandling);
        Navigator.pushReplacement(
            context,
            ScaleRoute(
                page: GameOverPage(
                    score: score,
                    difficultyColor: widget.color,
                    gameSpeed: widget.gameSpeed)));
      }
    } else {
      if (isValidBlock(activeBlock.type, activeBlock.row + 1, activeBlock.col,
          activeBlock.orientation))
        activeBlock.row++;
      else {
        saveMapData();
        removeCompletedRow();
        activeBlock = null;
      }
    }
    setState(() {});
  }

  void keybaordHandling(dynamic event) {
    if (activeBlock != null) {
      if (event.key == 's' || event.key == 'S') drop();
      if (event.key == 'w' || event.key == 'W') rotate();
      if (event.key == 'a' || event.key == 'A') moveLeft();
      if (event.key == 'd' || event.key == 'D') moveRight();
    }
  }

  bool isValidBlock(String blockName, int row, int col, int orientation) {
    List<List<int>> tiles = blocks[blockName]['tiles'][orientation];
    for (int r = 0; r < tiles.length; r++) {
      for (int c = 0; c < tiles[r].length; c++) {
        if (tiles[r][c] == 1) {
          if (row < 0 ||
              col < 0 ||
              row + r >= widget.height ||
              col + c >= widget.width ||
              mapData[row + r][col + c] != null) return false;
        }
      }
    }
    return true;
  }

  void saveMapData() {
    List<List<int>> tile =
        blocks[activeBlock.type]['tiles'][activeBlock.orientation];
    Color color = blocks[activeBlock.type]['color'];
    for (int r = 0; r < tile.length; r++) {
      for (int c = 0; c < tile[r].length; c++) {
        if (tile[r][c] == 1) {
          mapData[r + activeBlock.row][c + activeBlock.col] = color;
        }
      }
    }
  }

  ///create a new block.
  void makeNewBlock() {
    List blockOption = blocks.keys.toList();
    activeBlock = Block(blockOption[Random().nextInt(blockOption.length)])
      ..row = 0
      ..col = widget.width ~/ 2
      ..orientation = 0;
  }

  void removeCompletedRow() {
    int completed = 0;
    mapData.forEach((e) {
      if (!e.contains(null)) {
        completed++;
        mapData.remove(e);
        mapData.insert(0, List.from(emtpyRow));
      }
    });
    score += completed * 10;
    gameLoopTimer.cancel();
    if (widget.gameSpeed - score > 100) {
      gameLoopTimer = Timer.periodic(
          Duration(milliseconds: widget.gameSpeed - score), gameLoop);
    } else {
      gameLoopTimer = Timer.periodic(Duration(milliseconds: 100), gameLoop);
    }
  }

  void moveLeft() {
    if (activeBlock != null &&
        isValidBlock(activeBlock.type, activeBlock.row, activeBlock.col - 1,
            activeBlock.orientation)) {
      activeBlock.col--;
    }
  }

  void moveRight() {
    if (activeBlock != null &&
        isValidBlock(activeBlock.type, activeBlock.row, activeBlock.col + 1,
            activeBlock.orientation)) {
      activeBlock.col++;
    }
  }

  void rotate() {
    if (activeBlock != null) {
      int maxOrientation = blocks[activeBlock.type]['tiles'].length;
      int nextOrientation = (activeBlock.orientation + 1) % maxOrientation;
      if (isValidBlock(
          activeBlock.type, activeBlock.row, activeBlock.col, nextOrientation))
        activeBlock.orientation = nextOrientation;
      setState(() {});
    }
  }

  void drop() {
    if (activeBlock != null) {
      while (isValidBlock(activeBlock.type, activeBlock.row + 1,
          activeBlock.col, activeBlock.orientation)) activeBlock.row++;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget gameBody = Transform.scale(
      scale: 0.9,
      child: Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: widget.width / widget.height,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: widget.color, blurRadius: 30.0)
                ]),
            child: GameField(
                width: widget.width,
                height: widget.height,
                mapData: mapData,
                block: activeBlock),
          ),
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15.0),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Hero(
                  tag: 'score',
                  child: Material(
                      color: Colors.transparent,
                      child: Text('Score: ' + score.toString(),
                          style: Theme.of(context).textTheme.headline)),
                ),
              ),
            ),
          ),
        ),
        SizedBox.expand(child: VariousDiscs(50)),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth - constraints.maxHeight > 100.0) {
                    //orientation = landscape
                    return SizedBox(
                      width: constraints.maxHeight + 200.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            gameBody,
                            Expanded(
                              child: ControlPanel(
                                moveLeft: moveLeft,
                                moveRight: moveRight,
                                rotate: rotate,
                                drop: drop,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  //orientation = portrait
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: constraints.maxHeight / 16 * 9,
                        maxHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: gameBody,
                          ),
                        ),
                        ControlPanel(
                          moveLeft: moveLeft,
                          moveRight: moveRight,
                          rotate: rotate,
                          drop: drop,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    gameLoopTimer.cancel();
  }
}
