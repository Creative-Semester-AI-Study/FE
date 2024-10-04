import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final List<SvgPicture> profiles = [
    SvgPicture.asset("assets/images/profiles/profile_green.svg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(40),
            Stack(
              alignment: Alignment.center,
              children: [
                profiles[0],
                SvgPicture.asset(
                  "assets/images/profiles/app icon.svg",
                  height: 74,
                )
              ],
            ),
            const Gap(16),
            const Text(
              "닉네임",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.3,
                letterSpacing: -0.3,
              ),
            ),
            const Gap(12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 32,
                color: Colors.white,
                child: const Text("정보수정"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
