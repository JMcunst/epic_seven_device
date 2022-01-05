import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Main Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Move Splash route'),
          onPressed: () {
            // 눌렀을 때 두 번째 route로 이동합니다.
            Navigator.pop(
                context
            );
          },
        ),
      ),
    );
  }
}