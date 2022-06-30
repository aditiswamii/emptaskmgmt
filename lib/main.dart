import 'dart:async';

import 'package:emptaskmgmt/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.teal.shade400, // status bar color
    statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  runApp( MaterialApp(
      navigatorKey: navigatorKey,
     // theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: const Center(child: Text("Employee Task\nManagement",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
      ),

    );
  }
}

