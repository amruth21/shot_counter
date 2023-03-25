# shots
A mobile application powered by Google's Flutter framework, designed to track users alcohol consumption and promote safe drinking!
The application can be served/downloaded on Android, iOS, Mac, and Chrome based devices to reach as many users as possible.

![alt text](https://img.shields.io/github/languages/top/amruth21/shot_counter"test") 
![alt text](https://img.shields.io/github/commit-activity/y/amruth21/shot_counter "test")
![alt text](https://img.shields.io/github/stars/amruth21/shot_counter?style=social "test")

## Motivation

Just at the University of Maryland's campus alone 3/4 students engage in regular drinking, as a result of this rather than promoting abstinence(which isnt shown to work) providing resources to make their drinking experiences safer is vital. Oftentimes college students get caught up in the moment and dont accurately track the amounts of drinks they have had. Circumstances like this can lead to student's experiencing the [snowball effect](https://en.wikipedia.org/wiki/Snowball_effect) and get caught up in the moment. "shots" is designed to prevent this snowball effect and keep students safe!

## Description
The application contains a variety of different features which are meant to maximize the users safety to prevent alcohol poisoning and other harmful side effects of drinking. This app is meant to be a seamless solution to the countless health concerns that result from college drinking activities. The primary functionality of the app is to count the users drink intake and maintain a timer between drinks to caution the user as well as calculate their [Blood Alcohol Content](https://vaden.stanford.edu/super/learn/alcohol-drug-info/reduce-your-risk/what-blood-alcohol-concentration-bac). The application intially queries users for different characteristics such as age, gender, and weight in order to calibrate the BAC calculations. Upon reaching harmful BAC levels the application will alert the user as well as contact their emergency contact which they can configure in settings. The application will send the contact a message alerting them of the users high BAC levels and a location pin in emergency cases.

![Alt text](images/bac-graph.jpg?raw=true "BAC")


## Getting Started

### Dependencies

* Flutter
* Dart
* AndroidStudio
* XCode + tools
* materialUI for dart

### Installing

```
git clone https://github.com/amruth21/shot_counter
```

### Setting up Dependencies

Dependencies are automatically listed in the pubspec.yaml file and must be installed using
```
flutter pub get
```

### Executing program

Launch either Android Studio simulator or XCode simulator and run the following in your terminal
```
flutter run
```

### Importing to phone
TBA


## Authors

Amruth Nare (amruthnare.1@gmail.com) completed on March 25, 2023

## MIT License
