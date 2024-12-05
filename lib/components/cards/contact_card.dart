import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/theme/theme_colors.dart';

Widget contactCard() {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: Container(
      width: 353,
      height: 75,
      color: colorMainContact,
      child: Row(
        children: [
          const Gap(20),
          SvgPicture.asset(
            'assets/images/profiles/app icon.svg',
            height: 35,
          ),
          const Gap(13),
          const Text(
            "고소미와 상담해보세요!",
            style: TextStyle(
              // height: 23.4,
              color: Colors.white,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const Gap(43),
          const Text(
            "상담하러 가기",
            style: TextStyle(
              letterSpacing: -0.3,
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Gap(4),
          SvgPicture.asset(
            'assets/images/buttons/next_button.svg',
            height: 10,
          ),
        ],
      ),
    ),
  );
}
