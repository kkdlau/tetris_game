import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris_game/front_page.dart' as Settings;
import 'package:tetris_game/notifier.dart';

class Setting extends StatefulWidget {
  final bool darkTheme;
  Setting({Key key, this.darkTheme}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool darkTheme;

  @override
  void initState() {
    super.initState();
    darkTheme = !widget.darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Setting'),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.build),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Enable dark theme',
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Switch(
                    onChanged: (bool value) {
                      setState(() {
                        darkTheme = !value;
                        Settings.darkTheme = value;
                      });
                      if (darkTheme) {
                        _themeChanger.setTheme(ThemeData(
                            brightness: Brightness.light,
                            primaryColor: Colors.white,
                            canvasColor: Colors.white));
                      } else {
                        _themeChanger.setTheme(ThemeData(
                            brightness: Brightness.dark,
                            primaryColor: Colors.black,
                            canvasColor: Colors.black));
                      }
                    },
                    value: !darkTheme,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
