import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/theme/theme_colors.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';

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

Widget bottomBarIcon(
  String icon,
  String text, {
  required bool isSelected,
}) {
  return Column(
    children: [
      const Gap(10),
      SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          isSelected ? colorBottomBarSelected : colorBottomBarDefault,
          BlendMode.srcIn,
        ),
      ),
      const Gap(2),
      Text(
        text,
        style: TextStyle(
          color: isSelected ? colorBottomBarSelected : colorBottomBarDefault,
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w500,
          fontSize: 10,
          letterSpacing: -0.32,
          height: 1.2,
        ),
      ),
    ],
  );
}
