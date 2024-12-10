import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:circle_chart/circle_chart.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/api/load/load_statstics.dart';
import 'package:study_helper/theme/theme_colors.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({super.key});

  final Color barBackgroundColor =
      AppColors.contentColorWhite.darken().withOpacity(0.3);
  final Color barColor = colorBottomBarDefault;
  final Color touchedBarColor = colorBottomBarDefault;

  @override
  State<StatefulWidget> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  CancelToken? _cancelToken;
  final Duration animDuration = const Duration(milliseconds: 250);
  List<FlSpot> _futureDataSet = [];
  bool test = false;
  bool isLoaded = false;
  int touchedIndex = -1;
  bool isLoading = false;
  double loadingProgress = 0.0;
  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    _cancelToken?.cancel("Widget is disposing");
    super.dispose();
  }

  Future<void> loadDataSet() async {
    if (_cancelToken?.isCancelled ?? false) {
      _cancelToken = CancelToken();
    }

    setState(() {
      isLoading = true;
      loadingProgress = 0.0;
    });

    try {
      _futureDataSet = await loadStatistics(
        onProgress: (progress) {
          setState(() {
            loadingProgress = progress;
          });
        },
        cancelToken: _cancelToken,
      );
      isLoaded = true;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        print('Request was cancelled');
      } else {
        print('Error loading data: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "통계",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: colorDefault,
                  ),
                ),
                const Gap(12),
                const Divider(),
                const Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "월별 학습 통계",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: colorDefault,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (!test && !isLoaded) {
                            loadDataSet();
                          } else {
                            _cancelToken?.cancel("Widget is disposing");
                          }
                          test = !test;
                        });
                      },
                      style: const ButtonStyle(
                        foregroundColor:
                            WidgetStatePropertyAll(colorBottomBarDefault),
                      ),
                      child: Text(test ? 'TEST DATA MODE' : 'API MODE'),
                    ),
                  ],
                ),
                const Gap(38),
                Expanded(
                  child: Stack(
                    children: [
                      if (isLoading)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                  color: colorBottomBarDefault,
                                  value: loadingProgress),
                              const Gap(5),
                              Text(
                                  '${(loadingProgress * 100).toStringAsFixed(0)}%'),
                            ],
                          ),
                        ),
                      _LineChart(
                        isShowingMainData: test,
                        futureDataSet: _futureDataSet,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                const Divider(),
                const Gap(4),
                const Text(
                  "최근 학습",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorDefault,
                  ),
                ),
                const Gap(20),
                Flexible(
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "운영체제 3회차",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorDefault,
                                ),
                              ),
                              const Gap(4),
                              const Text(
                                "학습일 : 11/20/24",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: colorDefault,
                                ),
                              ),
                              // const Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CircleChart(
                                      progressColor: colorBottomBarSelected,
                                      showRate: true,
                                      progressNumber: 4,
                                      maxNumber: 10,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: const Icon(
                                            Icons.do_disturb_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        const Gap(10),
                                        const Text(
                                          "오답 복습 미완료",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    // layout: SwiperLayout.STACK,
                    itemCount: 3,
                    viewportFraction: 0.9,
                    loop: false,
                    // pagination: const SwiperPagination(),
                    // control: const SwiperControl(
                    //   iconNext: IconData(0),
                    //   iconPrevious: Icons.empty,
                    // ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart(
      {required this.isShowingMainData, required this.futureDataSet});
  final List<FlSpot> futureDataSet;
  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 1,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 1,
        minY: 0,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
      ];
  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData2_1(),
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 1:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1', style: style);
        break;
      case 2:
        text = const Text('2', style: style);
        break;
      case 3:
        text = const Text('3', style: style);
        break;
      case 4:
        text = const Text('4', style: style);
        break;
      case 5:
        text = const Text('5', style: style);
        break;
      case 6:
        text = const Text('6', style: style);
        break;
      case 7:
        text = const Text('7', style: style);
        break;
      case 8:
        text = const Text('8', style: style);
        break;
      case 9:
        text = const Text('9', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 11:
        text = const Text('11', style: style);
        break;
      case 12:
        text = const Text('12', style: style);
        break;
      case 13:
        text = const Text('(월)', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black12, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: colorBottomBarDefault,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          color: colorBottomBarDefault.withOpacity(0.1),
        ),
        spots: const [
          // FlSpot(0, 0),
          FlSpot(1, 0.68),
          FlSpot(2, 0.65),
          FlSpot(3, 0.84),
          FlSpot(4, 0.33),
          FlSpot(5, 0.30),
          FlSpot(6, 0.90),
          FlSpot(7, 0.97),
          FlSpot(8, 0.17),
          FlSpot(9, 0.77),
          FlSpot(10, 0.19),
          FlSpot(11, 0.65),
          FlSpot(12, 0.73),
        ],
      );
  LineChartBarData lineChartBarData2_1() {
    return LineChartBarData(
      isCurved: true,
      color: colorBottomBarDefault,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(
        show: true,
        color: colorBottomBarDefault.withOpacity(0.1),
      ),
      spots: futureDataSet,
    );
  }
}
