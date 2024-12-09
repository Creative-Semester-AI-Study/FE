import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:study_helper/api/auth_service.dart';
import 'package:study_helper/api/load_next_subject.dart';
import 'package:study_helper/api/load_subjects.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/model/user/user_model.dart';
import 'package:study_helper/model/user/user_preferences.dart';
import 'package:study_helper/screen/subject_screens/subject_detail_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  late Future<UserModel?> _userFuture;
  late Future<SubjectModel?> _nextSubjectFuture;
  late Future<List<SubjectModel>> _subjectFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    _subjectFuture = _loadSubjects();
    _nextSubjectFuture = _loadNextSubject();
  }

  Future<SubjectModel?> _loadNextSubject() async {
    // UserModel에서 토큰을 추출합니다.
    String? token = await AuthService().getToken();

    // 토큰을 사용하여 과목 데이터를 가져옵니다.
    return await getNextSubject(token!);
  }

  Future<List<SubjectModel>> _loadSubjects() async {
    // UserModel에서 토큰을 추출합니다.
    String? token = await AuthService().getToken();

    // 토큰을 사용하여 과목 데이터를 가져옵니다.
    return await getSubjects(token!);
  }

  Future<UserModel?> _loadUser() async {
    UserModel? user = await UserPreferences.getUser();
    if (user == null) {
      await AuthService().logout();
      return null;
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 0),
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
            FutureBuilder<SubjectModel?>(
              future: _nextSubjectFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final nextSubject = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "다음 예정 수업",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: colorDefault,
                        ),
                      ),
                      const Gap(12),
                      Card(
                        color: colorBottomBarDefault,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nextSubject.subjectName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${nextSubject.startTimeCoverted()} ~ ${nextSubject.endTimeCoverted()}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(20),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '지금 수강하러가기 >',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No subject data available'));
                }
              },
            ),
            const Gap(12),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "오늘 복습 진행도 : ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorDefault,
                      ),
                    ),
                    const Gap(12),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(100),
                      // width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      // lineHeight: 20.0,
                      animationDuration: 500,
                      percent: 0.9,

                      progressColor: colorBottomBarDefault,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(12),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '현재 수강중인 과목',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorDefault,
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
            ),
            const Gap(12),
            Expanded(
              child: FutureBuilder(
                future: _subjectFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubjectDetailScreen(
                                      subjectModel: snapshot.data![index])),
                            );
                          },
                          child: Card(
                            color: colorBottomBarSelected,
                            // elevation: 4.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].subjectName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${snapshot.data![index].professorName} 교수님',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data![index].days} ${snapshot.data![index].startTimeCoverted()} ~ ${snapshot.data![index].endTimeCoverted()}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
