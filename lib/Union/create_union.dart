import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../communitys/hlog_write.dart';
import '../constants.dart';

class CreateUnion extends StatefulWidget {

  @override
  State<CreateUnion> createState() => _CreateUnionPageState();
}

class _CreateUnionPageState extends State<CreateUnion> {
  dynamic _image; // 선택한 이미지의 파일을 저장할 변수

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // 선택한 이미지의 파일 경로 저장
      } else {
        _image = AssetImage('assets/logo.png'); // 사용자가 이미지를 선택하지 않았을 경우 기본 이미지로 설정
      }
    });
  }

  var _titleInputText = TextEditingController();
  var _dateInputText = TextEditingController();
  var _timeInputText = TextEditingController();
  var _locationInputText = TextEditingController();
  var _maxInputText = TextEditingController();
  DateTime? _selectedDate;

  @override
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
        actions: [
          TextButton(
            onPressed: (){},
            child: Text(
              'Next',
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              '제목',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            Text(
              '모임 날짜',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onTap: () {
                _showDatePicker(context);
              },
              readOnly: true,
              controller: _dateInputText,
              obscureText: false,
              decoration: InputDecoration(
                hintText: '모임 날짜',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '장소',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _locationInputText,
              obscureText: false,
              decoration: InputDecoration(
                hintText: ' 장소',
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
            const SizedBox(height: 20),
            Text(
              '최대 인원',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _maxInputText,
              obscureText: false,
              decoration: InputDecoration(
                hintText: ' 최대 인원',
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
            const SizedBox(height: 20),
            Text(
              '대표 사진 등록',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3), // 변경할 색상 설정
                  width: 2.0,
                ),
              ),
              child: _image == null
                  ? IconButton(
                onPressed: _pickImage,
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 50,
                ),
              )
                  : InkWell(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _image!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
