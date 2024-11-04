import 'package:flutter/material.dart';
import 'package:study_helper/bottom_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:study_helper/theme/theme_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        // include country code too
      ],
      debugShowCheckedModeBanner: false,
      title: '튜디',
      theme: ThemeData(
        scaffoldBackgroundColor: colorDefaultBackground,
        fontFamily: "SUIT",
        useMaterial3: true,
      ),
      home: const BottomBar(),
    );
  }
}
