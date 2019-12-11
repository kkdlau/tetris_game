import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'front_page.dart';
import 'notifier.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      child: AppCore(),
      create: (BuildContext context) => ThemeChanger(
        ThemeData(
          canvasColor: Colors.white,
          primaryColor: Colors.white
        )
      ),
    );
  }
}

class AppCore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Tetris',
      theme: theme.getTheme(),
      home: FrontPage(),
    );
  }
}
