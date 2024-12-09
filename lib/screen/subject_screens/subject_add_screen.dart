import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/api/service/subject_service.dart';
import 'package:study_helper/bottom_bar.dart';
import 'package:study_helper/model/user/user_preferences.dart';
import 'package:study_helper/theme/theme_colors.dart';

class SubjectAddScreen extends StatefulWidget {
  const SubjectAddScreen({super.key});

  @override
  State<SubjectAddScreen> createState() => _SubjectAddScreenState();
}

class _SubjectAddScreenState extends State<SubjectAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final SubjectService _subjectService = SubjectService();
  String subjectName = '';
  String professorName = '';
  List<String> selectedDays = [];
  final RoundedLoadingButtonController _roundedLoadingButton =
      RoundedLoadingButtonController();
  TextEditingController startHourController = TextEditingController();
  TextEditingController startMinuteController = TextEditingController();
  TextEditingController endHourController = TextEditingController();
  TextEditingController endMinuteController = TextEditingController();
  String startAmPm = '오전';
  String endAmPm = '오전';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 30));

  final List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
  final List<String> amPmOptions = ['오전', '오후'];

  @override
  void initState() {
    super.initState();
    _setCurrentTime();
  }

  String? _validateHour(String? value) {
    if (value == null || value.isEmpty) {
      return '시간을 입력해주세요';
    }
    int? hour = int.tryParse(value);
    if (hour == null || hour < 1 || hour > 12) {
      return '1에서 12 사이의 숫자를 입력해주세요';
    }
    return null;
  }

  String? _validateMinute(String? value) {
    if (value == null || value.isEmpty) {
      return '분을 입력해주세요';
    }
    int? minute = int.tryParse(value);
    if (minute == null || minute < 0 || minute > 59) {
      return '0에서 59 사이의 숫자를 입력해주세요';
    }
    return null;
  }

  void _setCurrentTime() {
    final now = DateTime.now();
    final end = now.add(const Duration(hours: 1));
    startHourController.text = _formatHour(now.hour);
    startMinuteController.text = now.minute.toString().padLeft(2, '0');
    endHourController.text = _formatHour(end.hour);
    endMinuteController.text = end.minute.toString().padLeft(2, '0');
    startAmPm = now.hour >= 12 ? '오후' : '오전';
    endAmPm = end.hour >= 12 ? '오후' : '오전';
  }

  String _formatHour(int hour) {
    final formattedHour = hour > 12 ? hour - 12 : hour;
    return formattedHour.toString().padLeft(2, '0');
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startHourController.text = _formatHour(picked.hour);
          startMinuteController.text = picked.minute.toString().padLeft(2, '0');
          startAmPm = picked.hour >= 12 ? '오후' : '오전';
          _adjustEndTime();
        } else {
          if (_isEndTimeValid(picked)) {
            endHourController.text = _formatHour(picked.hour);
            endMinuteController.text = picked.minute.toString().padLeft(2, '0');
            endAmPm = picked.hour >= 12 ? '오후' : '오전';
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('종료 시간은 시작 시간보다 늦어야 합니다.')),
            );
          }
        }
      });
    }
  }

  void _adjustEndTime() {
    final startHour = int.parse(startHourController.text);
    final startMinute = int.parse(startMinuteController.text);
    final startTimeInMinutes =
        (startHour + (startAmPm == '오후' ? 12 : 0)) * 60 + startMinute;
    final endTimeInMinutes = startTimeInMinutes + 60;
    final endHour = (endTimeInMinutes ~/ 60) % 24;
    final endMinute = endTimeInMinutes % 60;

    endHourController.text = _formatHour(endHour);
    endMinuteController.text = endMinute.toString().padLeft(2, '0');
    endAmPm = endHour >= 12 ? '오후' : '오전';
  }

  bool _isEndTimeValid(TimeOfDay endTime) {
    final startHour =
        int.parse(startHourController.text) + (startAmPm == '오후' ? 12 : 0);
    final startMinute = int.parse(startMinuteController.text);
    final endHour = endTime.hour;
    final endMinute = endTime.minute;

    if (endHour > startHour) return true;
    if (endHour == startHour && endMinute > startMinute) return true;
    return false;
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate.isBefore(startDate)) {
            endDate = startDate;
          }
        } else {
          if (picked.isAfter(startDate)) {
            endDate = picked;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('종료일은 시작일 이후여야 합니다.')),
            );
          }
        }
      });
    }
  }

  String convertTo24HourFormat(String hour, String minute, String amPm) {
    int hourInt = int.parse(hour);
    if (amPm == '오후' && hourInt != 12) {
      hourInt += 12;
    } else if (amPm == '오전' && hourInt == 12) {
      hourInt = 0;
    }
    return '${hourInt.toString().padLeft(2, '0')}:$minute';
  }

  void _addSubject() async {
    if (_formKey.currentState!.validate() && selectedDays.isNotEmpty) {
      _formKey.currentState!.save();
      final userData = await UserPreferences.getUser();
      // selectedDays를 정렬
      selectedDays
          .sort((a, b) => weekdays.indexOf(a).compareTo(weekdays.indexOf(b)));

      final subjectData = {
        "profileId": userData!.id,
        "subjectName": subjectName,
        "days": selectedDays.join(', '),
        "professorName": professorName,
        "startTime": convertTo24HourFormat(
            startHourController.text, startMinuteController.text, startAmPm),
        "endTime": convertTo24HourFormat(
            endHourController.text, endMinuteController.text, endAmPm),
      };
      print(subjectData.toString());
      bool success = await _subjectService.addSubject(subjectData);

      if (success && mounted) {
        _roundedLoadingButton.success();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('과목이 성공적으로 추가되었습니다.')),
        );
        // Navigator.pop(context); // 과목 추가 후 이전 화면으로 돌아갑니다.
        Get.offAll(() => const BottomBar(index: 0));
      } else if (mounted) {
        _roundedLoadingButton.error();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('과목 추가에 실패했습니다. 다시 시도해주세요.')),
        );
        _roundedLoadingButton.reset();
      }
    } else if (selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수업 요일을 선택해주세요')),
      );
      _roundedLoadingButton.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('과목 정보 추가'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: '과목명'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '과목명을 입력해주세요';
                    }
                    return null;
                  },
                  onSaved: (value) => subjectName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: '교수명'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '교수명을 입력해주세요';
                    }
                    return null;
                  },
                  onSaved: (value) => professorName = value!,
                ),
                const SizedBox(height: 20),
                const Text('수업 요일'),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: weekdays.sublist(0, 4).map((day) {
                          return FilterChip(
                            label: Text(day),
                            selectedColor: colorBottomBarDefault,
                            selected: selectedDays.contains(day),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedDays.add(day);
                                } else {
                                  selectedDays.remove(day);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: weekdays.sublist(4).map((day) {
                          return FilterChip(
                            selectedColor: colorBottomBarDefault,
                            label: Text(day),
                            selected: selectedDays.contains(day),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedDays.add(day);
                                } else {
                                  selectedDays.remove(day);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildTimeInput(
                    '시작 시간',
                    startHourController,
                    startMinuteController,
                    () => _selectTime(context, true), (value) {
                  setState(() => startAmPm = value!);
                }, startAmPm),
                const SizedBox(height: 20),
                _buildTimeInput('종료 시간', endHourController, endMinuteController,
                    () => _selectTime(context, false), (value) {
                  setState(() => endAmPm = value!);
                }, endAmPm),
                const SizedBox(height: 20),
                _buildDateInput(
                    '시작일', startDate, () => _selectDate(context, true)),
                const SizedBox(height: 20),
                _buildDateInput(
                    '종료일', endDate, () => _selectDate(context, false)),
                const Gap(30),
                RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width,
                  controller: _roundedLoadingButton,
                  color: colorBottomBarDefault,
                  onPressed: () {
                    _addSubject();
                  },
                  child: const Text('과목 추가'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeInput(
    String label,
    TextEditingController hourController,
    TextEditingController minuteController,
    VoidCallback onSelectTime,
    void Function(String?) onAmPmChanged,
    String currentAmPm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Wrap(
              spacing: 8.0,
              children: amPmOptions.map((option) {
                return FilterChip(
                  label: Text(option),
                  selectedColor: colorBottomBarDefault,
                  selected: currentAmPm == option,
                  onSelected: (bool selected) {
                    if (selected) {
                      onAmPmChanged(option);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: hourController,
                decoration: const InputDecoration(labelText: '시'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validateHour,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    String? error = _validateHour(value);
                    if (error != null) {
                      hourController.text =
                          value.substring(0, value.length - 1);
                      hourController.selection = TextSelection.fromPosition(
                          TextPosition(offset: hourController.text.length));
                    }
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: minuteController,
                decoration: const InputDecoration(labelText: '분'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validateMinute,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    String? error = _validateMinute(value);
                    if (error != null) {
                      minuteController.text =
                          value.substring(0, value.length - 1);
                      minuteController.selection = TextSelection.fromPosition(
                          TextPosition(offset: minuteController.text.length));
                    }
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onSelectTime,
              child: const Text('선택'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateInput(
      String label, DateTime? date, VoidCallback onSelectDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(date != null
                  ? "${date.year}-${date.month}-${date.day}"
                  : "날짜 선택"),
            ),
            ElevatedButton(
              onPressed: onSelectDate,
              child: const Text('선택'),
            ),
          ],
        ),
      ],
    );
  }
}
