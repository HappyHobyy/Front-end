import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/root_page.dart';
import 'package:hobbyhobby/widgets/union.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

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
  var _opentalkInputText = TextEditingController();
  var _tag1InputText = TextEditingController();
  var _tag2InputText = TextEditingController();
  var _textEditingInputText = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleInputText.dispose();
    _dateInputText.dispose();
    _timeInputText.dispose();
    _locationInputText.dispose();
    _maxInputText.dispose();
    _opentalkInputText.dispose();
    _tag1InputText.dispose();
    _tag2InputText.dispose();
    _textEditingInputText.dispose();
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
            onPressed: (){
              if (_titleInputText.text.isEmpty ||
                  _dateInputText.text.isEmpty ||
                  _locationInputText.text.isEmpty ||
                  _maxInputText.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      ' 모든 항목에 입력해주세요.',
                    ),
                    backgroundColor: Constants.primaryColor,
                    duration: Duration(seconds: 1),
                  ),
                );
                return;
              }
              setState(() {
                _isLoading = true; // 버튼을 눌렀을 때 대기 상태로 설정
              });
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
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
                          onPressed: (){
                            if (_opentalkInputText.text.isEmpty ||
                                _textEditingInputText.text.isEmpty ||
                                _tag1InputText.text.isEmpty ||
                                _tag2InputText.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    ' 모든 항목에 입력해주세요.',
                                  ),
                                  backgroundColor: Constants.primaryColor,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _isLoading = true; // 버튼을 눌렀을 때 대기 상태로 설정
                            });
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: RootPage(),
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: Duration(milliseconds: 300),
                              ),
                            );
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 15,
                            )
                          ),
                        ),
                      ],
                    ),

                    body: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            '오픈톡 링크',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _opentalkInputText,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: ' 오픈톡 링크',
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
                            '커뮤니티 태그',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0), // 오른쪽에 패딩 추가
                                  child: TextField(
                                    controller: _tag1InputText, // 첫 번째 TextField의 컨트롤러
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: '커뮤니티 태그 1',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue, // 예시 색상
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 패딩 추가
                                  child: TextField(
                                    controller: _tag2InputText, // 두 번째 TextField의 컨트롤러
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: '커뮤니티 태그 2',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue, // 예시 색상
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '모임 설명',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _textEditingInputText,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: '내용을 입력하세요.',
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
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
              child: InkWell(
                onTap: _pickImage,
                child: _image == null
                    ? Icon(
                  Icons.add_circle_outline,
                  size: 50,
                )
                    : _image is File
                    ? Image.file(
                  _image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
                    : Image(
                  image: _image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
