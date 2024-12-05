import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:study_helper/api/login.dart';
import 'package:study_helper/bottom_bar.dart';
import 'package:study_helper/theme/theme_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({context, super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      if (await loginStatus(username, password)) {
        await secureStorage.write(key: 'isLoggedIn', value: 'true');
        Get.offAll(() => const BottomBar());
      } else {
        _showErrorDialog();
      }
    }
  }

  void _showErrorDialog() {
    _btnController.error();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorDefaultBackground,
        title: const Text('로그인 실패'),
        content: const Text('아이디 또는 비밀번호를 확인해주세요.'),
        actions: [
          TextButton(
            style: const ButtonStyle(
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            onPressed: () {
              Navigator.pop(context);
              _btnController.reset();
            },
            child: const Text(
              '확인',
              style: TextStyle(color: colorBottomBarDefault),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorDefaultBackground,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Text(
                    "튜디 로그인",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 5,
                    color: colorBottomBarDefault,
                    width: 175,
                  ),
                ],
              ),
              const Gap(30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: colorBottomBarDefault,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: '아이디',
                        floatingLabelStyle:
                            TextStyle(color: colorBottomBarDefault),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBottomBarDefault,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _btnController.reset();
                          return '아이디를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    TextFormField(
                      cursorColor: colorBottomBarDefault,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        // suffixIcon: Icon(Icons.radio_button_checked_rounded),
                        labelText: '비밀번호',
                        floatingLabelStyle:
                            TextStyle(color: colorBottomBarDefault),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBottomBarDefault,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _btnController.reset();
                          return '비밀번호를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    const Text("학사정보시스템 계정으로 로그인"),
                    const Gap(15),
                    RoundedLoadingButton(
                      color: colorBottomBarDefault,
                      controller: _btnController,
                      onPressed: _login,
                      child: const Text('로그인',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
