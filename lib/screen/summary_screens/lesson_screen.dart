import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/screen/summary_screens/quiz_screen.dart';
import 'package:study_helper/screen/summary_screens/summary_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "수업 요약",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: 30,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1회차 운영체제 수업",
                    style: TextStyle(
                      fontSize: 20,
                      color: colorDefault,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "11월 11일",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Gap(30),
                          Text(
                            "12:00 ~ 14:00",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "요약완료",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(10),
            const Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Scrollbar(
                    thickness: 2, // 스크롤바의 두께
                    radius: Radius.circular(100), // 스크롤바 모서리의 둥근 정도
                    thumbVisibility: false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0, left: 30, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Gap(30),
                            Text(
                              '인공지능은 데이터를 학습하고 분석하며 문제를 해결하는 기술로, 현대 기술 혁신의 핵심으로 자리 잡고 있다. 인공지능은 크게 세 가지로 구분된다. 첫째, 약인공지능은 특정 작업에 특화된 시스템으로 음성 인식, 이미지 처리, 추천 알고리즘 등에서 사용된다. 둘째, 강인공지능은 인간 수준의 종합적인 사고와 학습 능력을 갖춘 시스템으로, 아직 연구 단계에 있으며 실용화는 이루어지지 않았다. 셋째, 초인공지능은 인간 지능을 초월하는 수준의 시스템으로, 이론적 개념에 가깝다. 이러한 기술은 주로 기계 학습과 딥러닝을 기반으로 한다. 기계 학습은 데이터를 학습하여 예측 모델을 생성하는 기술로, 지도 학습, 비지도 학습, 강화 학습으로 나뉜다. 딥러닝은 인공신경망을 활용하여 대규모 데이터를 처리하고 복잡한 문제를 해결하는 데 사용된다. 딥러닝은 컴퓨터 비전, 자연어 처리, 음성 변환 등 다양한 분야에서 혁신을 이끌고 있다. 인공지능의 응용 사례는 매우 다양하다. 의료 분야에서는 질병 진단과 치료 계획 수립을 돕고 있으며, 금융 분야에서는 투자 분석과 사기 탐지에 활용된다. 제조업에서는 공정 자동화와 예측 유지보수, 물류 산업에서는 경로 최적화와 공급망 관리에 기여하고 있다. 예를 들어, 인공지능은 자율 주행 차량의 핵심 기술로 사용되며, 교통 흐름을 분석하고 사고를 예방하는 데 중요한 역할을 한다. 또한, 교육 분야에서는 학습자 맞춤형 교육 콘텐츠를 제공하여 학습 효율성을 높이고 있다. 이처럼 인공지능은 다양한 산업에서 생산성과 효율성을 향상시키는 데 기여하고 있다. 하지만 인공지능에는 몇 가지 한계점이 존재한다. 첫째, 데이터 품질이 낮으면 학습 결과의 신뢰성이 떨어질 수 있다. 둘째, 인공지능의 의사결정 과정이 블랙박스처럼 불투명하여 결과를 해석하기 어려운 문제가 있다. 이를 해결하기 위해 설명 가능한 인공지능 기술이 개발되고 있다. 셋째, 인공지능의 확산으로 인한 일자리 감소와 같은 사회적 영향도 우려된다. 특히 단순 반복 작업은 인공지능으로 대체될 가능성이 높다. 이로 인해 새로운 직업 훈련과 교육이 필요하다는 의견이 제기되고 있다. 넷째, 데이터 프라이버시와 보안 문제도 큰 도전 과제 중 하나다. 인공지능이 민감한 데이터를 처리하면서도 개인 정보 보호를 준수하도록 규제를 강화할 필요가 있다. 세계 각국은 이러한 한계를 극복하고 인공지능 기술을 더욱 발전시키기 위해 대규모 투자를 진행하고 있다. 미국은 인공지능 연구와 상용화를 위한 주요 프로젝트를 추진하고 있으며, 중국은 첨단 기술 분야에서 세계적 리더가 되기 위해 적극적으로 투자하고 있다. 유럽연합은 인공지능의 윤리적 활용을 보장하기 위한 규제와 정책을 정비하고 있다. 예를 들어, 유럽연합은 AI 법안을 통해 데이터 사용과 알고리즘의 투명성을 강화하고 있다. 이러한 글로벌 경쟁 속에서 인공지능 기술은 국가 간 기술력의 격차를 가르는 중요한 요소가 되고 있다. 앞으로 인공지능이 발전하면서 새로운 기회를 창출하고 사회 전반에 걸쳐 혁신적인 변화를 가져올 것으로 기대된다. 예를 들어, 인공지능은 지속 가능한 에너지 시스템을 개발하고, 기후 변화에 대응하는 데 중요한 역할을 할 수 있다. 또한, 의료 진단의 정확성을 높이고 전염병 확산을 방지하는 데도 기여할 수 있다. 이처럼 인공지능은 단순한 기술적 도구를 넘어 인간의 삶을 혁신하는 데 핵심적인 역할을 할 것이다. 그러나 기술 발전에 따른 윤리적 문제와 사회적 책임도 간과하지 않아야 하며, 지속 가능한 방식으로 인공지능을 활용하는 것이 중요하다.',
                              style: TextStyle(
                                color: Colors.black,
                                wordSpacing: 1.1,
                                letterSpacing: 1.3,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Card(
                        color: colorBottomBarDefault,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SummaryScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "요약내용 수정",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(4),
                    Flexible(
                      child: Card(
                        color: colorBottomBarDefault,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QuizScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "학습하기",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
