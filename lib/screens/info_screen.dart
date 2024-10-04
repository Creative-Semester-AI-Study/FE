import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/cards/info_card.dart';
import 'package:study_helper/theme/theme_colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorButtonNotSelectedBackground,
      appBar: AppBar(
        elevation: 0.2,
        surfaceTintColor: Colors.white,
        shadowColor: colorShadow,
        backgroundColor: Colors.white,
        toolbarHeight: 71,
        title: const Padding(
          padding: EdgeInsets.only(
            top: 26,
            left: 16.0,
            bottom: 16,
          ),
          child: Text(
            "정보",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: -0.3,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 24, bottom: 24),
                child: Text(
                  "유용한 법률 정보를\n확인해보세요! 🧑🏻‍⚖️",
                  style: TextStyle(
                    color: colorButtonNotSelectedFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    letterSpacing: -0.3,
                    height: 1.3,
                  ),
                ),
              ),
              Column(
                children: [
                  infoCard("이혼 관련 승소 사례",
                      "의뢰인은 피고와 혼인 기간 내내 무시와 경제적 구속, 인격적 차별 등 부당한 대우를 받으며 약 30년을 살아왔습니다. 아이들을 양육하며 참아왔으나 의뢰인의 아버지에게 막말하는 모습과 의뢰인에게 폭행을 하게 되며 참을 수 없는 지경에 이르렀습니다. 또한"),
                  const Gap(12),
                  infoCard("미성년자 주식회사 법인 설립 가능할까요?",
                      "저는 현재 만 17세인 고등학생입니다. 저는 또래 친구들을 위한 온라인 교육 콘텐츠 제작 및 판매 사업을 구상하고 있습니다. 저는 뜻이 맞는 친구들과 함께 주식회사를 설립하여 사업을 시작하려고 합니다. 각자의 강점을 살려, 콘텐츠 기획, 제작, 편집, 마케팅 등의 역할을 분담할 계획입니다. 미성년자도 주식회사 법인 설립이 가능한가요? 저와 제 친구들이 임원을 맡을 수 있을까요?"),
                  const Gap(12),
                  infoCard("상호 변경, 망설이지 마세요!",
                      "세계 1위 스포츠 용품 기업 ‘나이키’의 원래 이름을 아시나요? 1978년까지 나이키의 상호는 ‘블루 리본 스포츠’였습니다. 세계적 회사인 아마존, 구글, 틴더, 서브웨이, 야후, 엘지 모두 과거에 상호를 변경한 적이 있습니다. 이들 기업은 상호 변경에 너무 늦은 때는 없다는 것을 보여줍니다. 이 회사들은 상호 변경을 통해 방향을 전환했고, 성공을 이루었습니다."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
