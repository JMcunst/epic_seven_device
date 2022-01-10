import 'package:epic_seven_device/screen/home_screen.dart';
import 'package:epic_seven_device/screen/more_screen.dart';
import 'package:epic_seven_device/widget/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screen/login_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController? controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESDevice',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue, brightness: Brightness.dark)
            .copyWith(secondary: Colors.black),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              Container(
                child: const Center(
                  child: Text('search'),
                ),
              ),
              Container(
                child: const Center(
                  child: Text('save'),
                ),
              ),
              MoreScreen()
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
