import 'package:flutter/material.dart';
import 'package:study_helper/model/subject/subject_model.dart';

class SubjectDetail extends StatefulWidget {
  final SubjectModel subjectModel;
  const SubjectDetail({super.key, required this.subjectModel});

  @override
  State<SubjectDetail> createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(widget.subjectModel.toJson().toString()),
          ],
        ),
      ),
    );
  }
}
