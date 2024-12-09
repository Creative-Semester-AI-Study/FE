import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:study_helper/api/load/load_subjects_by_date.dart';
import 'package:study_helper/components/cards/study_cards/completed_card.dart';
import 'package:study_helper/components/cards/study_cards/disabled_card.dart';
import 'package:study_helper/components/cards/study_cards/ongoing_card.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/theme/theme_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  late Future<List<SubjectModel>> _futureSubject;
  bool isStudy = true;

  @override
  void initState() {
    super.initState();
    _futureSubject = _loadSubjectModel();
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<List<SubjectModel>> _loadSubjectModel() async {
    return await loadSubjectByDate(formatDate(_selectedDay), isStudy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!isStudy) {
                      setState(() {
                        isStudy = true;
                        _futureSubject = _loadSubjectModel();
                      });
                    }
                  },
                  child: Text(
                    "학습",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: isStudy ? colorDefault : colorDisabled,
                    ),
                  ),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () {
                    if (isStudy) {
                      setState(() {
                        isStudy = false;
                        _futureSubject = _loadSubjectModel();
                      });
                    }
                  },
                  child: Text(
                    "복습",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: isStudy ? colorDisabled : colorDefault,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
              ),
              child: TableCalendar(
                focusedDay: _focusedDay,
                availableCalendarFormats: const {
                  CalendarFormat.month: '월별 보기',
                  CalendarFormat.twoWeeks: '2주 보기',
                  CalendarFormat.week: '주별 보기'
                },
                headerVisible: true,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarFormat: _calendarFormat,
                locale: 'ko-kr',
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _futureSubject = _loadSubjectModel();
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2030, 12, 30),
                headerStyle: const HeaderStyle(
                  titleCentered: false,
                  // formatButtonShowsNext: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                ),
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,
                  selectedDecoration: BoxDecoration(
                    color: colorBottomBarDefault,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Gap(30),
            Expanded(
              flex: 1,
              child: PhysicalModel(
                color: Colors.white,
                elevation: 0.1,
                shadowColor: const Color(0x00000010),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                clipBehavior: Clip.hardEdge,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 25, right: 25),
                    child: isStudy
                        ? FutureBuilder<List<SubjectModel>>(
                            future: _futureSubject,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: colorBottomBarDefault,
                                ));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      const Icon(Icons.check),
                                      const Gap(12),
                                      Text(
                                        '${DateFormat('MM월 dd일').format(_selectedDay)}에 진행할 학습이 없습니다!',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Gap(2),
                                      const Text(
                                        '혹은 서버 에러일지도...? ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                  children: snapshot.data!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    SubjectModel subject = entry.value;
                                    bool isLast =
                                        index == snapshot.data!.length - 1;
                                    if (subject.learningStatus == '요약 보기') {
                                      return completedCard(
                                        subjectName: subject.subjectName,
                                        timeText:
                                            "${subject.startTimeCoverted()} ~ ${subject.endTimeCoverted()}",
                                        isLast: isLast,
                                      );
                                    } else if (subject.learningStatus ==
                                        '녹음 시작') {
                                      return ongoingCard(
                                        context: context,
                                        subjectName: subject.subjectName,
                                        timeText:
                                            "${subject.startTimeCoverted()} ~ ${subject.endTimeCoverted()}",
                                        isLast: isLast,
                                      );
                                    } else {
                                      return disabledCard(
                                        subjectName: subject.subjectName,
                                        timeText:
                                            "${subject.startTime} ~ ${subject.endTime}",
                                        isLast: isLast,
                                      );
                                    }
                                  }).toList(),
                                );
                              }
                            },
                          )
                        : FutureBuilder<List<SubjectModel>>(
                            future: _futureSubject,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: colorBottomBarDefault,
                                ));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      const Icon(Icons.check),
                                      const Gap(12),
                                      Text(
                                        '${DateFormat('MM월 dd일').format(_selectedDay)}에 진행할 복습이 없습니다!',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                  children: snapshot.data!
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    SubjectModel subject = entry.value;
                                    bool isLast =
                                        index == snapshot.data!.length - 1;
                                    if (subject.learningStatus == '요약 보기') {
                                      return completedCard(
                                        subjectName: subject.subjectName,
                                        timeText:
                                            "${subject.startTimeCoverted()} ~ ${subject.endTimeCoverted()}",
                                        isLast: isLast,
                                      );
                                    } else if (subject.learningStatus ==
                                        '녹음 시작') {
                                      return ongoingCard(
                                        context: context,
                                        subjectName: subject.subjectName,
                                        timeText:
                                            "${subject.startTimeCoverted()} ~ ${subject.endTimeCoverted()}",
                                        isLast: isLast,
                                      );
                                    } else {
                                      return disabledCard(
                                        subjectName: subject.subjectName,
                                        timeText:
                                            "${subject.startTimeCoverted()} ~ ${subject.startTimeCoverted()}",
                                        isLast: isLast,
                                      );
                                    }
                                  }).toList(),
                                );
                              }
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
