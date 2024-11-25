import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/bottom_bar_icon.dart';
import 'package:study_helper/screens/home_screen.dart';
import 'package:study_helper/screens/info_screen.dart';
import 'package:study_helper/screens/profile_screen.dart';
import 'package:study_helper/screens/statistics_screens/statistics_screen.dart';
import 'package:study_helper/screens/study_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();

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
            BarChartSample1(),
            ProfileScreen(),
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
