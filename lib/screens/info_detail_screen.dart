import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/theme/theme_colors.dart';

class InfoDetailScreen extends StatefulWidget {
  const InfoDetailScreen({super.key});

  @override
  State<InfoDetailScreen> createState() => _InfoDetailScreenState();
}

class _InfoDetailScreenState extends State<InfoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorMainBackground,
        backgroundColor: colorMainBackground,
        toolbarHeight: 0,
      ),
      backgroundColor: colorMainBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  color: Colors.white,
                  height: 47,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "완료",
                            style: TextStyle(
                              color: colorButtonNotSelectedFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                // height: double.maxFinite,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "상호 변경, 망설이지 마세요!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.5,
                          letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Gap(42),
                      Container(
                        width: 32,
                        height: 4,
                        color: Colors.black,
                      ),
                      const Gap(16),
                      const Text(
                        "세계 1위 스포츠 용품 기업 ‘나이키’의 원래 이름을 아시나요? 1978년까지 나이키의 상호는 ‘블루 리본 스포츠’였습니다. 세계적 회사인 아마존, 구글, 틴더, 서브웨이, 야후, 엘지 모두 과거에 상호를 변경한 적이 있습니다.\n\n 이들 기업은 상호 변경에 너무 늦은 때는 없다는 것을 보여줍니다. 이 회사들은 상호 변경을 통해 방향을 전환했고, 성공을 이루었습니다.\n\n 오늘은 상호 변경 절차에 대한 모든 내용을 정리해 드리겠습니다.\n\n 상호 변경 절차\n\n 사용 가능한 상호인지 확인\n 먼저 변경을 원하는 상호가 등기 가능한지 확인해야 합니다. 회사를 설립할 때, 상호 등기에 많은 제한이 따르는 것처럼 상호 변경시에도 동일한 제한이 있습니다.\n\n 회사의 종류 표시: 회사의 상호 중에는 그 종류에 따라 합명회사, 합자회사, 유한책임회사, 주식회사, 또는 유한회사의 문자를 사용해야 합니다. 지점 표시 문자 사용 금지: 지점이 아니면, 상호에 지점, 지사, 지부, 출장소 등의 문자나 영업부, 판매부 등 영업부문임을 표시하는 문자를 사용할 수 없습니다. 대리점, 특약점 등은 상호에 사용 가능합니다. 동종 영업, 동일 상호 금지: 변경하려는 것과 동종영업의 동일한 상호가 같은 시, 군 내에 있으면 신청이 거절될 수 있습니다. 동종영업은 영업의 주요 부분만 일치해도 인정됩니다. 이를 방지하기 위해 인터넷 등기소 사이트에서 상호명을 검색해보세요. 타인의 영업으로 오인할 수 있는 상호 사용 금지: 누구든지 부정한 목적으로 타인의 영업으로 오인할 수 있는 상호를 사용하지 못합니다. 손해배상배상 청구, 상호 사용폐지 청구를 당할 수 있고 과태료가 부과될 수 있습니다. 널리 인식된 상호 사용 금지: 국내에 널리 인식된 타인의 성명, 상호, 기타 타인의 영업임을 표시하는 표지와 동일하거나 유사한 것을 사용하여 타인의 영업상의 시설 또는 활동과 혼동하게 해서는 안됩니다(부정경쟁방지법). 형사 제재를 당할 수 있습니다. 공공기관 오인 문자 사용 금지: 국가, 공공단체 또는 그 소속기관, 공법인과 관련성이 있다고 오인될 우려가 있는 문자는 사용할 수 없습니다. 사회질서에 반하는 문자: 외설스러운 문자 등을 사용할 수 없습니다. 사회적 유명 인사의 성명권을 침해할 우려가 있는 경우, 상호를 사용할 수 없습니다. 회사의 종류를 표시하는 부분을 제외하고 신청인의 상호가 업종을 표시하는 문자만으로 구성되어 있는 경우, 사용할 수 없습니다. 법에 따라 인허가 받은 법인이 아니면 사용할 수 없는 문자가 있습니다.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(50),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
