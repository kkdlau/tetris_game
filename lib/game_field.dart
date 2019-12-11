import 'package:flutter/material.dart';
import 'block_data.dart';

class GameField extends StatelessWidget {
  final int width;
  final int height;
  final List<List<Color>> mapData;
  final Block block;

  const GameField(
      {Key key,
      @required this.width,
      @required this.height,
      this.mapData,
      this.block})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FieldPaint(
          width: width,
          height: height,
          block: block,
          brightness: Theme.of(context).brightness,
          mapData: mapData),
    );
  }
}

class FieldPaint extends CustomPainter {
  final int width;
  final int height;
  final Brightness brightness;
  final List<List<Color>> mapData;
  final Block block;
  Canvas mainCanvas;
  double tileWidth;
  double tileHeight;

  FieldPaint(
      {@required this.brightness,
      @required this.width,
      @required this.height,
      this.mapData,
      this.block});

  @override
  void paint(Canvas canvas, Size size) {
    mainCanvas = canvas;
    paintGameFieldLines(size);
    canvas.save();
    if (mapData.length != 0) paintBlocks();
    if (block != null) paintActiveBlock();
    canvas.restore();
  }

  void paintGameFieldLines(Size size) {
    Rect background = Offset(0.0, 0.0) & Size(size.width, size.height);
    Paint backgroundPen = Paint();
    if (brightness == Brightness.light) backgroundPen.color = Colors.white;
    mainCanvas.drawRect(background, backgroundPen);
    Paint line = Paint()
      ..color = Colors.blue[300]
      ..strokeWidth = 3;

    double rowPosition = size.height / height;
    double colPosition = size.width / width;

    tileWidth = colPosition;
    tileHeight = rowPosition;

    for (int r = 0; r <= height; r++) {
      rowPosition = size.height / height * r;
      mainCanvas.drawLine(
          Offset(0, rowPosition), Offset(size.width, rowPosition), line);
    }
    for (int c = 0; c <= width; c++) {
      colPosition = size.width / width * c;
      mainCanvas.drawLine(
          Offset(colPosition, 0), Offset(colPosition, size.height), line);
    }
  }
  void paintBlocks() {
    for (int r = 0; r < mapData.length; r++) {
      for (int c = 0; c < mapData[r].length; c++) {
        if (mapData[r][c] != null) {
          drawRect(c * tileWidth, r * tileHeight, mapData[r][c], brightness == Brightness.light? Colors.black: Colors.white);
        }
      }
    }
  }

  void paintActiveBlock() {
    List<List<int>> tiles = blocks[block.type]['tiles'][block.orientation];
    Color color = blocks[block.type]['color'];
    for (int r = 0; r < tiles.length; r++) {
      for (int c = 0; c < tiles[r].length; c++) {
        if (tiles[r][c] == 1) {
          drawRect((c + block.col) * tileWidth, (block.row + r) * tileHeight, color, brightness == Brightness.light? Colors.black: Colors.white);
        }
      }
    }
  }

  void drawRect(double x, double y, Color color, Color strokeColor) {
    Paint pen = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;
    Rect tile = Offset(x, y) & Size(tileWidth, tileHeight);
    mainCanvas.drawRect(tile, pen);
    pen
      ..style = PaintingStyle.stroke
      ..color = strokeColor;
    mainCanvas.drawRect(tile, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
