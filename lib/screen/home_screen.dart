import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/components/buttons/category_button.dart';
import 'package:study_helper/components/buttons/detail_category_button.dart';
import 'package:study_helper/components/cards/contact_card.dart';
import 'package:study_helper/theme/theme_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<String> categoryName = [
    "성범죄",
    "마약 / 도박",
    "교통사고",
    "폭행",
    "성범죄",
    "마약 / 도박",
    "교통사고",
    "폭행",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
              InkWell(
                onTap: () {},
                child: Ink(
                  child: contactCard(),
                ),
              ),
              const Gap(40),
              const Text(
                "분야 선택하기",
                style: TextStyle(
                  letterSpacing: -0.3,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(5),
              const Text(
                "상담받고 싶은 분야를 선택해주세요",
                style: TextStyle(
                  letterSpacing: -0.3,
                  color: colorSubFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      categoryButton("성범죄"),
                      categoryButtonDisabled("마약 / 도박"),
                      categoryButtonDisabled("교통사고"),
                      categoryButtonDisabled("폭행"),
                      categoryButtonDisabled("성범죄"),
                      categoryButtonDisabled("성범죄"),
                      categoryButtonDisabled("성범죄"),
                      categoryButtonDisabled("성범죄"),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailCategoryButton("성매매"),
                      detailCategoryButton("성폭력 / 강제추행"),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailCategoryButton("미성년 대상 성범죄"),
                      detailCategoryButton("디지털 성범죄"),
                    ],
                  ),
                  const Gap(80),
                ],
              ),
              const Divider(
                color: colorCardBackground,
                height: 4,
                thickness: 3,
              ),
              const Gap(30),
              const Text(
                "오늘의 법률 정보",
                style: TextStyle(
                  letterSpacing: -0.3,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(5),
              const Text(
                "고소미가 추천하는 오늘의 법률 정보를 확인해보세요.",
                style: TextStyle(
                  letterSpacing: -0.3,
                  color: colorSubFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Gap(10),
              Container(
                height: 128,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Thumbnail.png'),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white10, Colors.white70]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
