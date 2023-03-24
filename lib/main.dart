import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'dart:ui';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shot Counter',
        theme: ThemeData(
          fontFamily: 'Gotham',
        ),
        home: const MyHomePage(title: 'wasted'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // all of these fields are final

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _colorR = 250;
  int _colorG = 245;
  int _colorB = 245;

  double _first_time = 0.0;
  double _curr_time = 0.0;
  double BAC = 0.0;

  void _incrementColor() {
    setState(() {
      if (_colorG > 0) {
        _colorG = _colorG - 35;
      }
      if (_colorB > 0) {
        _colorB = _colorB - 35;
      }
      if (_colorB <= 0 && _colorG <= 0 && _colorR > 100) {
        _colorR = _colorR - 50;
      }
    });
  }

  void _increment() {
    _incrementCounter();
    _incrementColor();
    if (_counter > 1) {
      _calcBAC();
    }
  }

  void _calcBAC() {}

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == 1) {
        var temp = DateTime.now();
        int hour = temp.hour;
        int mins = temp.minute;
        _first_time = hour + mins / 60;
      } else {
        var temp = DateTime.now();
        int hour = temp.hour;
        int mins = temp.minute;
        _curr_time = hour + mins / 60;
      }

      if (_counter > 10) {
        // change to BAC
        print("we in");
        Dialogs.materialDialog(
            msg: 'Your BAC level is too high!',
            title: "WARNING",
            color: Colors.white,
            dialogWidth: .3,
            context: context,
            actions: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'I understand',
                iconData: Icons.no_drinks,
                textStyle: TextStyle(color: Colors.grey),
                iconColor: Colors.grey,
              ),
            ]);
      }

      // need to call setState to rebuild the widget
    });
  }

  void _resetFields() {
    setState(() {
      _counter = 0;
      _colorR = 250;
      _colorG = 245;
      _colorB = 245;
      _first_time = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // runs every time setState called

    return Scaffold(
      backgroundColor: Color.fromARGB(255, _colorR, _colorG, _colorB),
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title, style: TextStyle(color: Color.fromARGB(255, _colorR, _colorG, _colorB))),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MySettingsPage(title: 'Settings');
                }));
              },
              icon: Icon(Icons.settings, size: 24.0,),
              label: Text('Settings'), // <-- Text
            ),
            /*
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MySettingsPage(title: 'Settings');
            }));
          },
          child: const Text('Settings'),
        ),*/
            /*
        Builder(builder: (context) => IconButton(
          iconSize: 512,
          icon: Image.asset('images/image-2.jpg', scale: 2.5),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MySettingsPage(title: 'Settings');
            }));
          },
        ))*/
          ]),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _increment,
                  child: Image.asset('images/shot-glass.png', scale: 2.5),
                )),
            Container(
                alignment: Alignment.center,
                child: Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
          ],
        ),
      ),
    );
  }
}
