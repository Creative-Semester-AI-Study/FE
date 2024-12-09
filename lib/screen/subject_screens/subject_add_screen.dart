import 'package:flutter/material.dart';

class SubjectAddScreen extends StatefulWidget {
  const SubjectAddScreen({super.key});

  @override
  State<SubjectAddScreen> createState() => _SubjectAddScreenState();
}

class _SubjectAddScreenState extends State<SubjectAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '과목 추가',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: const Placeholder(),
    );
  }
}
