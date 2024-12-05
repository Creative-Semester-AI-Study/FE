import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:study_helper/bottom_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:study_helper/screens/login_screens/login_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;
  runApp(const GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
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
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && snapshot.data == true) {
              return const BottomBar();
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    String? isLoggedIn = await secureStorage.read(key: 'isLoggedIn');
    return isLoggedIn == 'true';
  }
}
