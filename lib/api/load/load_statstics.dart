import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/service/auth_service.dart';

Future<List<FlSpot>> loadStatistics({
  Function(double)? onProgress,
  CancelToken? cancelToken,
}) async {
  Dio dio = Dio();
  List<FlSpot> result = [];
  try {
    String? token = await AuthService().getToken();
    for (int month = 1; month <= 12; month++) {
      if (cancelToken?.isCancelled ?? false) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.cancel,
        );
      }

      String formattedMonth = month.toString().padLeft(2, '0');
      String date = '${DateTime.now().year}-$formattedMonth';
      final response = await dio.get(
        "$url/api/stats/month/$date",
        options: Options(
          headers: {'Authorization': token},
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        result.add(FlSpot(
            month.toDouble(), response.data['monthReviewPercentage'] + 0.0));
      }

      if (onProgress != null) {
        onProgress(month / 12);
      }
    }
  } catch (e) {
    print("--ERROR OCCURRED--");
    print(e);
    if (e is DioException) {
      if (e.type == DioExceptionType.cancel) {
        print('Request was cancelled');
      } else {
        // 다른 DioError 처리
      }
    }
    rethrow;
  }

  return result;
}
