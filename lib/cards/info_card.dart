import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/screens/info_detail_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

Widget infoCard(String title, String detail) {
  // return GestureDetector(
  //   onTap: () => {},
  //   child:
  return OpenContainer(
    closedShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    closedElevation: 0.3,
    openBuilder: (context, __) {
      return const SwipeToDismissWrap(
        child: InfoDetailScreen(),
      );
    },
    closedBuilder: (context, action) {
      return Container(
        color: Colors.white,
        child: SizedBox(
          height: 172,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16, right: 16, bottom: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    color: colorMainScreen,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(20),
                Text(
                  detail,
                  maxLines: 4,
                  style: const TextStyle(
                    color: colorButtonNotSelectedFont,
                    height: 1.3,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(9),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "전체 글 보기 ",
                      style: TextStyle(
                        color: colorDetailInfo,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        letterSpacing: -0.3,
                      ),
                    ),
                    // Gap(2),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: colorDetailInfo,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class SwipeToDismissWrap extends StatefulWidget {
  final Widget child;

  const SwipeToDismissWrap({super.key, required this.child});

  @override
  State<SwipeToDismissWrap> createState() => _SwipeToDismissWrapState();
}

class _SwipeToDismissWrapState extends State<SwipeToDismissWrap> {
  bool _swipeInProgress = false;
  late double _startPosX;

  final double _swipeStartAreaWidth = 60;
  final double _swipeMinLength = 50;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        if (details.localPosition.dx < _swipeStartAreaWidth) {
          _swipeInProgress = true;
          _startPosX = details.localPosition.dx;
        }
      },
      onHorizontalDragUpdate: (details) {
        if (_swipeInProgress &&
            details.localPosition.dx > _startPosX + _swipeMinLength) {
          HapticFeedback.mediumImpact();
          Navigator.of(context).pop();
        }
      },
      onHorizontalDragEnd: (_) => _swipeInProgress = false,
      child: widget.child,
    );
  }
}
