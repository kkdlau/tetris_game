import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//copied from DartPad, implicit animation example
class DiscData {
  static final _rng = Random();

  double size;
  Color color;
  Alignment alignment;

  DiscData() {
    color = Color.fromARGB(
      _rng.nextInt(100),
      _rng.nextInt(255),
      _rng.nextInt(255),
      _rng.nextInt(255),
    );
    size = _rng.nextDouble() * 70 + 10;
    alignment = Alignment(
      _rng.nextDouble() * 2 - 1,
      _rng.nextDouble() * 2 - 1,
    );
  }
}

class VariousDiscs extends StatefulWidget {
  final numberOfDiscs;

  VariousDiscs(this.numberOfDiscs);
  
  @override
  _VariousDiscsState createState() => _VariousDiscsState();
}

class _VariousDiscsState extends State<VariousDiscs> {
  final _discs = <DiscData>[];
  Timer backgroundTimer;

  @override
  void initState() {
    super.initState();
    backgroundTimer = Timer.periodic(Duration(seconds: 5), _makeDiscs);
    _makeDiscs(backgroundTimer);
    SchedulerBinding.instance.addPostFrameCallback(((_) => _makeDiscs(backgroundTimer)));
  }

  void _makeDiscs(Timer timer) {
    _discs.clear();
    for (int i = 0; i < widget.numberOfDiscs; i++) {
      _discs.add(DiscData());
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          for (final disc in _discs)
            Positioned.fill(
              child: AnimatedAlign(
                duration: Duration(seconds: 4),
                curve: Curves.easeInOut,
                alignment: disc.alignment,
                child: AnimatedContainer(
                  duration: Duration(seconds: 4),
                  decoration: BoxDecoration(
                    color: disc.color,
                    shape: BoxShape.circle,
                  ),
                  height: disc.size,
                  width: disc.size,
                ),
              ),
            ),
        ],
      );
  }

  @override
  void dispose() {
    super.dispose();
    backgroundTimer.cancel();

  }
}