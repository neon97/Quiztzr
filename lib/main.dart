import 'dart:async';
import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/Topics/topicMain.dart';
import 'package:edgeclass/widgets.dart/appbackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EdgeClassQuizer',
      theme: ThemeData(
          textTheme: GoogleFonts.sourceSansProTextTheme(),
          primaryColor: Colors.black),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //function
  _startTimer() {
    Timer(Duration(seconds: 3), _moveToHome);
  }

  _moveToHome() {
    routeTo(context, TopicMain());
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getting the sizes of the devices
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return ScafTile(
        widgeter: Scaffold(
      backgroundColor: Colors.transparent,
      body: backGround(Center(
        child: Image.asset("assets/white_logo.png"),
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
