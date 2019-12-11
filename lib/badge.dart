import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Badge extends StatefulWidget {
  final double expandedWidth;
  Badge({Key key, this.expandedWidth}) : super(key: key);

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  double _badgeWidth = 0.0;
  double _opactiy = 0.0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _badgeWidth = widget.expandedWidth;
        _opactiy = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedOpacity(
          duration: Duration(milliseconds: 800),
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('TETRIS', style: Theme.of(context).textTheme.display4)),
          opacity: _opactiy,
        ),
        AnimatedContainer(
          curve: Curves.easeOutQuart,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          duration: Duration(milliseconds: 1500),
          width: _badgeWidth,
          height: 10.0,
        )
      ],
    );
  }
}
