import 'package:card_swiper/card_swiper.dart';
import 'package:circle_chart/circle_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/api/load_subject.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/model/subject/subject_preferences.dart';
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
  late Future<List<SubjectModel>> _subjectFuture;
  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    _subjectFuture = _loadSubjects();
  }

  Future<List<SubjectModel>> _loadSubjects() async {
    // _userFuture에서 UserModel을 가져옵니다.
    UserModel user = await _userFuture;

    // UserModel에서 토큰을 추출합니다.
    String token = user.getToken();

    // 토큰을 사용하여 과목 데이터를 가져옵니다.
    return await getSubjects(token);
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
              "홈",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: colorDefault,
              ),
            ),
            const Gap(12),
            const Divider(),
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
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "사용자 정보",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
            const Divider(),
            Expanded(
              child: FutureBuilder(
                future: _subjectFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "운영체제 3회차",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: colorDefault,
                                  ),
                                ),
                                const Gap(4),
                                const Text(
                                  "학습일 : 11/20/24",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: colorDefault,
                                  ),
                                ),
                                // const Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CircleChart(
                                        progressColor: colorBottomBarSelected,
                                        showRate: true,
                                        progressNumber: 4,
                                        maxNumber: 10,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            child: const Icon(
                                              Icons.do_disturb_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          const Gap(10),
                                          const Text(
                                            "오답 복습 미완료",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      // layout: SwiperLayout.STACK,
                      itemCount: 3,
                      viewportFraction: 0.9,
                      loop: false,
                      // pagination: const SwiperPagination(),
                      // control: const SwiperControl(
                      //   iconNext: IconData(0),
                      //   iconPrevious: Icons.empty,
                      // ),
                    );
                  } else {
                    return const Center(
                        child: Text('No subject data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
