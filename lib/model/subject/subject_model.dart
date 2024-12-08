class SubjectModel {
  late int profileId;
  late int id;
  late String subjectName;
  late String professorName;
  late String startTime;
  late String endTime;

  SubjectModel({
    required this.profileId,
    required this.subjectName,
    required this.id,
    required this.professorName,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'id': id,
      'subjectName': subjectName,
      'professorName': professorName,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      profileId: json['profileId'] ?? 0,
      id: json['id'] ?? 0,
      subjectName: json['subjectName'] ?? '',
      professorName: json['professorName'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }
}
