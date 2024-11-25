import 'dart:ui';

import 'package:flutter/material.dart';

const colorBottomBarSelected = Color(0xFF79AEFF);
const colorFinishedCircle = Color.fromARGB(179, 121, 175, 255);
const colorLine = Color(0x30062D5F);
const colorDetailScreenAppbar = Color(0xFFD9EBFF);
const colorCardDisabled = Color.fromARGB(255, 171, 198, 251);
const colorBottomBarDefault = Color(0xFF062D5F);
const colorDefaultBackground = Color(0xFFF3F3F3);
const colorDefault = Color(0xFF1b1b1b);
const colorDisabled = Color.fromARGB(51, 27, 27, 27);
const colorMainContact = Color(0xFF474747);
const colorLoginSelectBorder = Color(0xFF656565);
const colorDefaultBorder = Color(0xFF9f9f9f);
const colorMainBackground = Color(0xFFe2e2e2);

//CardBackground
const colorCardBackground = Color(0xfff5f5f5);
const colorPointColor = Color(0xfff4f0f0);

const colorOnFocused = Color(0xFF3b3b3b);
const colorOnFocusedBorder = Color(0xFFFFFFFF);

const colorMainFont = Color(0xff000000);
const colorSubFont = Color(0xff979797);

const colorButtonNotSelectedFont = Color(0xFF777777);
const colorButtonNotSelectedBackground = Color(0xFFFAFAFA);

const colorShadow = Color(0xFFD9D9D9);
const colorDetailInfo = Color(0xFFA9A9A9);

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * value)).round(),
      (green + ((255 - green) * value)).round(),
      (blue + ((255 - blue) * value)).round(),
    );
  }

  Color avg(Color other) {
    final red = (this.red + other.red) ~/ 2;
    final green = (this.green + other.green) ~/ 2;
    final blue = (this.blue + other.blue) ~/ 2;
    final alpha = (this.alpha + other.alpha) ~/ 2;
    return Color.fromARGB(alpha, red, green, blue);
  }
}
