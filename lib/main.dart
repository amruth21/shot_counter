import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'dart:ui';
import 'settings.dart';
import 'package:gender_picker/source/enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'shots',
        theme: ThemeData(
          fontFamily: 'Gotham',
        ),
        home: const MyHomePage(title: 'shots'));
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
  double _BAC = 0.0;

  int age = 21;
  Gender gender = Gender.Male;
  int weight = 180;

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

  void _calcBAC() {
    double genderConst;
    double hours = _curr_time - _first_time;

    if (gender == Gender.Male) {
      genderConst = 0.68;
    } else if (gender == Gender.Female) {
      genderConst = 0.55;
    } else {
      genderConst = 0.62;
    }
    print("Constant: ${genderConst}");
    print("weight: ${weight}");
    print("shots ${_counter}");
    print("hours: ${hours}");

    int gramsWeight = 454 * weight;
    int gramsOfAlcohol = _counter * 14;
    double bac = (gramsOfAlcohol / (gramsWeight * genderConst)) * 100;
    bac = bac - (hours * 0.015);
    _BAC = double.parse(bac.toStringAsFixed(2));
  }

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

      _calcBAC();

      if (_BAC > .30 || _counter > 14) {
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
    print('First Time: $_first_time');
    print('Curr Time: $_curr_time');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, _colorR, _colorG, _colorB),
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title, style: TextStyle(color: Color.fromARGB(255, _colorR, _colorG, _colorB))),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                _navigateSettings(context);
              },
              icon: Icon(
                Icons.settings,
                size: 24.0,
              ),
              label: Text('Settings'), // <-- Text
            ),
          ]),
      body: Center(
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64))),
              Container(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                    child: GestureDetector(
                      onTap: _increment,
                      child: Image.asset('images/shot-glass.png', scale: 2.5),
                    )),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ],
          ),
          Container(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32))),
          Container(
            alignment: Alignment.center,
            child: Text(
              'BAC: $_BAC',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _navigateSettings(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MySettingsPage(title: 'Settings')));
    weight = result['weight'];
    age = result['age'];
    gender = result['gender'];
  }
}
