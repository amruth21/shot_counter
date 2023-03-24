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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'Gotham',
        ),
        home: const MyHomePage(title: 'Shot Counter Proto'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      backgroundColor: Color.fromARGB(255, _colorR, _colorG, _colorB),
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: Colors.black,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Image.asset('images/shot-glass.png', scale: 2.5),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MySettingsPage(title: 'Settings');
                }));
              },
            )
            /*
          Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () { Navigator.push(context, 
                          MaterialPageRoute(builder: (context) {
                            return const MySettingsPage(title: 'SecondPage');
                          })
                        );
                        },
                  child: Image.asset('images/setting.png', scale: 2.5),
                )),*/
          ]),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
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
            Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const MySettingsPage(title: 'SecondPage');
                    }));
                  },
                  child: Image.asset('images/shot-glass.png', scale: 2.5),
                )),
          ],
        ),
      ),
    );
  }
}
