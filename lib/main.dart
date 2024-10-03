import 'package:flutter/material.dart';
import 'package:study_helper/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '고소미',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "SUIT",
        useMaterial3: true,
      ),
      home: const BottomBar(),
    );
  }
}
