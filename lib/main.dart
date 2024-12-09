import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/bottom_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:study_helper/screen/login_screens/login_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;
  runApp(GetMaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    title: '튜디',
    theme: ThemeData(
      scaffoldBackgroundColor: colorDefaultBackground,
      fontFamily: "SUIT",
      useMaterial3: true,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '튜디',
      theme: ThemeData(
        scaffoldBackgroundColor: colorDefaultBackground,
        fontFamily: "SUIT",
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        // include country code too
      ],
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && snapshot.data == true) {
              return const BottomBar(index: 0);
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    return await AuthService().isLoggedIn();
  }
}
