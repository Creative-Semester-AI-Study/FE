import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_helper/util/bottom_bar_icon.dart';
import 'package:study_helper/screen/home_screen.dart';
import 'package:study_helper/screen/profile_screen.dart';
import 'package:study_helper/screen/statistics_screens/statistics_screen.dart';
import 'package:study_helper/screen/study_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  final int index;
  const BottomBar({super.key, required this.index});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int selected;
  bool heart = false;
  late final PageController controller;
  @override
  void initState() {
    selected = widget.index;
    controller = PageController(initialPage: selected);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: StylishBottomBar(
        backgroundColor: Colors.white,
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.blink,
          iconStyle: IconStyle.simple,
        ),
        items: [
          _bottomBarItem(
            icon: 'assets/images/bottom_bar/icons/home.svg',
            text: '홈',
          ),
          _bottomBarItem(
            icon: 'assets/images/bottom_bar/icons/pencil.svg',
            text: '학습/복습',
          ),
          _bottomBarItem(
            icon: 'assets/images/bottom_bar/icons/bar-chart.svg',
            text: '통계',
          ),
          _bottomBarItem(
            icon: 'assets/images/bottom_bar/icons/user.svg',
            text: '마이페이지',
          ),
        ],
        currentIndex: selected,
        notchStyle: NotchStyle.square,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            const HomeScreen(),
            const StudyScreen(),
            StatisticsScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

BottomBarItem _bottomBarItem({
  required String icon,
  required String text,
}) {
  return BottomBarItem(
    icon: bottomBarIcon(icon, text, isSelected: true),
    selectedIcon: bottomBarIcon(icon, text, isSelected: false),
    title: Text(text),
  );
}
