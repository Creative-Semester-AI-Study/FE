class SubjectModel {
  late int profileId;
  late int id;
  late String subjectName;
  late String professorName;
  late String startTime;
  late String endTime;
  late String learningStatus;
  late String days;

  SubjectModel({
    required this.profileId,
    required this.subjectName,
    required this.id,
    required this.professorName,
    required this.startTime,
    required this.endTime,
    required this.learningStatus,
    required this.days,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'id': id,
      'subjectName': subjectName,
      'professorName': professorName,
      'startTime': startTime,
      'endTime': endTime,
      'leraningStatus': learningStatus,
      'days': days,
    };
  }

  String startTimeCoverted() {
    return formatTimeString(startTime);
  }

  String endTimeCoverted() {
    return formatTimeString(endTime);
  }

  String formatTimeString(String time) {
    // 시간 문자열에서 시와 분을 추출
    List<String> parts = time.split(':');
    if (parts.length < 2) return time; // 잘못된 형식이면 원래 문자열 반환

    int hour = int.parse(parts[0]);
    String minute = parts[1];

    // 오전/오후 결정 및 시간 조정
    String period = '오전';
    if (hour >= 12) {
      period = '오후';
      if (hour > 12) hour -= 12;
    }

    // 0시는 12시로 표시
    if (hour == 0) hour = 12;

    // 결과 문자열 생성
    return '$period $hour:$minute';
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      profileId: json['profileId'] ?? 0,
      id: json['id'] ?? json['subjectId'] ?? 0,
      subjectName: json['subjectName'] ?? '',
      professorName: json['professorName'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      learningStatus:
          json['learningStatus'] ?? json['reviewed'].toString() ?? '',
      days: json['days'] ?? '',
    );
  }
}
