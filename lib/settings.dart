import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key, required this.title});

  final String title;

  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  int _age = 18;
  Gender _gender = Gender.Male;
  int _weight = 50;

  Widget getWidget(bool showOtherGender, bool alignVertical) {
    return Container(
      child: Center(
          child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,

        // to show what's selected on app opens, but by default it's Male
        selectedGender: _gender,
        selectedGenderTextStyle: TextStyle(color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        onChanged: (Gender? gen) {
          if (gen != null) {
            setState(() {
              _gender = gen;
            });
          }
        },
        //Alignment between icons
        equallyAligned: true,

        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 50, //default : 40
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(myController);
    print(_age);
    print(_weight);
    print(_gender);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 55, 100, 191),
        appBar: AppBar(
          backgroundColor: Colors.black,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Slider(
                        value: _age.toDouble(),
                        min: 18,
                        max: 35,
                        divisions: 17,
                        label: _age.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _age = value.toInt();
                          });
                        },
                      ),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Text('AGE', style: TextStyle(fontFamily: "Gotham")))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextFormField(
                            controller: myController,
                            keyboardType: TextInputType.number,
                            onChanged: (text) {
                              setState(() {
                                var value = int.tryParse(text);
                                if (value == null) {
                                  _weight = 140;
                                } else {
                                  _weight = int.parse(text);
                                }
                              });
                            }),
                      ),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Text('WEIGHT(lbs)', style: TextStyle(fontFamily: "Gotham")))),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16), child: Center(child: getWidget(false, false))),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Text('GENDER', style: TextStyle(fontFamily: "Gotham")))),
                      /*
                      GenderPickerWithImage(
                        showOtherGender: false,
                        verticalAlignedText: false,
                        selectedGender: Gender.Male,
                        selectedGenderTextStyle: TextStyle(color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                        unSelectedGenderTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                        onChanged: (Gender? gen) {
                          setState(() {
                            _gender = gen.toString();
                          });
                        },
                        equallyAligned: true,
                        animationDuration: Duration(milliseconds: 300),
                        isCircular: true,
                        // default : true,
                        opacityOfGradient: 0.4,
                        padding: const EdgeInsets.all(3),
                        size: 50, //default : 40
                      ),
                      */
                    ],
                  ),
                ),
              ],
            ),

            /*Center(
          
          child: Stack(children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('AGE'))),
          Container(
              alignment: Alignment.center,
              child: Slider(
                value: _age.toDouble(),
                min: 18,
                max: 70,
                divisions: 52,
                label: _age.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _age = value.toInt();
                  });
                },
              )),
              
        ]))
*/
            /*

Container(

              alignment: Alignment.center,
              child: SizedBox(
    width: 200,
    height: 50,
  child: TextField(
                  decoration: new InputDecoration(labelText: "Enter your number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]))),









      body: SafeArea(
          child: ListView(padding: EdgeInsets.all(24), children: <Widget>[
        Text('AGE'),
        Slider(
          value: _age.toDouble(),
          min: 18,
          max: 70,
          divisions: 52,
          label: _age.round().toString(),
          onChanged: (double value) {
            setState(() {
              _age = value.toInt();
            });
          },
        ),
        TextField(
            decoration: new InputDecoration(labelText: "Enter your number"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly])
      ])),*/
          )
        ])));
  }
}

Container _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade400,
  );
}
