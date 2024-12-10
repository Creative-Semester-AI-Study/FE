import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/model/user/user_model.dart';
import 'package:study_helper/model/user/user_preferences.dart';
import 'package:study_helper/theme/theme_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RoundedLoadingButtonController _roundedLoadingButtonController =
      RoundedLoadingButtonController();

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
      body: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "마이페이지",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: colorDefault,
              ),
            ),
            const Gap(12),
            const Divider(),
            const Gap(12),
            const Text(
              "사용자 정보",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const Gap(12),
            FutureBuilder<UserModel>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '이름: ${user.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                '학년: ${user.grade}학년',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                '학과: ${user.department}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                '상태: ${user.status}생',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('No user data available'));
                }
              },
            ),
            const Gap(12),
            const Divider(),
            const Gap(12),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('프로필 수정'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 프로필 수정 페이지로 이동
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('설정'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 설정 페이지로 이동
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('과목 수정'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 주문 내역 페이지로 이동
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('개발자 목록'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 찜 목록 페이지로 이동
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('고객 센터'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 고객 센터 페이지로 이동
                    },
                  ),
                ],
              ),
            ),
            RoundedLoadingButton(
              controller: _roundedLoadingButtonController,
              onPressed: AuthService().logout,
              color: colorBottomBarDefault,
              child: const Text(
                '로그아웃',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
