import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/auth_service.dart';
import 'package:study_helper/api/load_reviews.dart';
import 'package:study_helper/bottom_bar.dart';
import 'package:study_helper/model/review/review_model.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/model/subject/subject_preferences.dart';
import 'package:study_helper/theme/theme_colors.dart';

class SubjectDetailScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  const SubjectDetailScreen({super.key, required this.subjectModel});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  late final Future<List<ReviewModel>> _futureReviewList;
  late String? token;
  @override
  void initState() {
    super.initState();
    _futureReviewList = _loadReviews();
  }

  Future<List<ReviewModel>> _loadReviews() async {
    token = await AuthService().getToken();
    return await loadReviews(token!, widget.subjectModel.id);
  }

  Future<void> _deleteSubject(
      BuildContext context, String token, int id) async {
    try {
      final dio = Dio();
      final response = await dio.delete(
        '$url/study/subject/$id',
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        await SubjectPreferences.removeSubject(id);

        if (!mounted) return; // 위젯이 여전히 마운트된 상태인지 확인

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('과목이 성공적으로 삭제되었습니다.')),
        );

        Get.offAll(() => const BottomBar(index: 0));
      } else {
        throw Exception('Failed to delete subject');
      }
    } catch (e) {
      print('Error deleting subject: $e');
      if (mounted) {
        // 위젯이 여전히 마운트된 상태인지 확인
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('과목 삭제 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text('정말로 ${widget.subjectModel.subjectName} 과목을 삭제하시겠습니까?'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              '취소',
              style: TextStyle(
                color: colorBottomBarDefault,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text(
              '삭제',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () async {
              Get.back();
              await _deleteSubject(context, token!, widget.subjectModel.id);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '과목 상세',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDeleteConfirmationDialog(context);
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.subjectModel.subjectName} 상세 정보',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const Gap(12),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '과목명: ${widget.subjectModel.subjectName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      '교수명: ${widget.subjectModel.professorName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      '수업요일: ${widget.subjectModel.days}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      '수업시간: ${widget.subjectModel.startTimeCoverted()} ~ ${widget.subjectModel.endTimeCoverted()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(3),
                    FutureBuilder(
                      future: _futureReviewList,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Text(
                            '학습 횟수: 0',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          );
                        } else {
                          return Text(
                            '학습 횟수: ${snapshot.data?.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Gap(12),
            const Divider(),
            const Gap(12),
            Text(
              '${widget.subjectModel.subjectName} 학습 기록',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _futureReviewList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return snapshot.data!.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.question_mark_outlined),
                                Gap(12),
                                Text(
                                  '학습을 진행한 적이 없습니다.',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  color: colorBottomBarSelected,
                                  // elevation: 4.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.subjectModel.subjectName} $index회차',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '${snapshot.data![index].getFormattedDateTime()} 학습',
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
                      child: Text('학습정보가 존재하지 않습니다.'),
                    );
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
