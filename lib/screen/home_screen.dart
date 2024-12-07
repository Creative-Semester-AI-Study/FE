import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_helper/model/user/user_model.dart';
import 'package:study_helper/model/user/user_preferences.dart';
import 'package:study_helper/theme/theme_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UserModel> _userFuture;
  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
  }

  Future<UserModel> _loadUser() async {
    return await UserPreferences.getUser() ??
        UserModel(
            grade: 0,
            name: 'null',
            id: 0,
            department: 'department',
            status: 'status',
            token: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: FutureBuilder<UserModel>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name),
                    // 여기에 더 많은 위젯을 추가할 수 있습니다.
                    Text('Grade: ${user.grade}'),
                    Text('Department: ${user.department}'),
                    Text('Status: ${user.status}'),
                    // 필요한 만큼 위젯을 추가하세요
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No user data available'));
          }
        },
      ),
    );
  }
}
