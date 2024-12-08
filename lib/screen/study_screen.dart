import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/components/cards/study_cards/completed_card.dart';
import 'package:study_helper/components/cards/study_cards/disabled_card.dart';
import 'package:study_helper/components/cards/study_cards/ongoing_card.dart';
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
  bool isStudy = true;

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
            const Gap(12),
            TableCalendar(
              focusedDay: _focusedDay,
              headerVisible: false,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarFormat: CalendarFormat.week,
              locale: 'ko-kr',
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2030, 12, 30),
              // headerStyle: HeaderStyle(),
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                // markerDecoration: BoxDecoration(color: colorFinishedCircle),
                // weekendTextStyle: TextStyle(
                //   fontWeight: FontWeight.w500,
                //   fontSize: 32,
                // ),
                // defaultTextStyle: TextStyle(
                //   fontWeight: FontWeight.w500,
                //   fontSize: 32,
                // ),
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
            const Gap(20),
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
                    child: Column(
                      children: [
                        completedCard(
                          subjectName: "알고리즘",
                          timeText: "10:00 ~ 12:00",
                          isLast: false,
                        ),
                        ongoingCard(
                          context: context,
                          subjectName: "운영체제",
                          timeText: "12:00 ~ 14:00",
                          isLast: false,
                        ),
                        disabledCard(
                          subjectName: "데이터베이스",
                          timeText: "14:30 ~ 16:30",
                          isLast: false,
                        ),
                        disabledCard(
                          subjectName: "컴퓨터네트워크",
                          timeText: "17:00 ~ 19:00",
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
