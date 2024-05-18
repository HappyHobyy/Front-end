import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CreateUnion extends StatefulWidget {
  const CreateUnion({super.key});

  @override
  State<CreateUnion> createState() => _CreateUnionPageState();
}

class _CreateUnionPageState extends State<CreateUnion> {
  var _titleInputText = TextEditingController();
  var _dateInputText = TextEditingController();
  var _timeInputText = TextEditingController();
  var _locationInputText = TextEditingController();
  var _maxInputText = TextEditingController();

  DateTime? _selectedDate;

  void dispose() {
    _titleInputText.dispose();
    _dateInputText.dispose();
    _timeInputText.dispose();
    _locationInputText.dispose();
    _maxInputText.dispose();
    super.dispose();
  }
  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            dateOrder: DatePickerDateOrder.ymd,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                _selectedDate = newDateTime;
                _dateInputText.text = "${_selectedDate!.year}.${_selectedDate!.month}.${_selectedDate!.day}";
              });
            },
          ),
        );
      },
    );
  }

  @override
  bool _isLoading = false;
  bool _loginFailed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '모임 생성',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: _titleInputText,
              obscureText: false,
              decoration: InputDecoration(
                hintText: ' 제목',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3), // 변경할 색상 설정
                    width: 2.0, // 테두리 두께 설정
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.primaryColor, // 변경할 색상 설정
                    width: 2.0, // 테두리 두께 설정
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
