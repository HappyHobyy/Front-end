import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Union/union_model.dart';
import 'package:hobbyhobby/Union/union_view_model.dart';
import 'package:hobbyhobby/root_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';

class CreateUnion extends StatefulWidget {
  final AuthManager authManager;
  final Function(dynamic) onMeetingCreated;
  final UnionViewModel unionViewModel;

  const CreateUnion({
    Key? key,
    required this.authManager,
    required this.onMeetingCreated,
    required this.unionViewModel,
  }) : super(key: key);

  @override
  State<CreateUnion> createState() => _CreateUnionPageState();
}

class _CreateUnionPageState extends State<CreateUnion> {
  File? _image; // 선택한 이미지의 파일을 저장할 변수
  late AuthManager _authManager;
  late UnionViewModel _unionViewModel;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    _unionViewModel = widget.unionViewModel;
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
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // 선택한 이미지의 파일 경로 저장
      } else {
        _image = null; // 사용자가 이미지를 선택하지 않았을 경우 기본 이미지로 설정
      }
    });
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
                _dateInputText.text =
                "${_selectedDate!.year}.${_selectedDate!.month}.${_selectedDate!.day}";
              });
            },
          ),
        );
      },
    );
  }

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 10,
            initialTimerDuration: Duration(hours: 0, minutes: 0),
            onTimerDurationChanged: (Duration newDuration) {
              setState(() {
                _selectedTime = TimeOfDay(
                    hour: newDuration.inHours, minute: newDuration.inMinutes % 60);
                _timeInputText.text =
                "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}";
              });
            },
          ),
        );
      },
    );
  }

  Future<void> _createMeeting() async {
    if (_tag1InputText.text.isNotEmpty && _tag2InputText.text.isEmpty) {
      // SingleMeeting 추가
      SingleMeeting newMeeting = SingleMeeting(
        articleId: null,
        imageUrl: _image != null ? _image!.path : 'assets/logo.png',
        userNickname: _authManager.currentUserName ?? 'Unknown',
        tag1: int.parse(_tag1InputText.text),
        title: _titleInputText.text,
        maxPeople: int.parse(_maxInputText.text),
        meetingDate: DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
        openTalkLink: _opentalkInputText.text,
        createDate: null,
        location: _locationInputText.text,
        mainText: _textEditingInputText.text,
      );
      await widget.unionViewModel.createSingleMeeting(newMeeting);
      widget.onMeetingCreated(newMeeting);
    } else if (_tag1InputText.text.isNotEmpty && _tag2InputText.text.isNotEmpty) {
      // UnionMeeting 추가
      UnionMeeting newMeeting = UnionMeeting(
        articleId: null,
        imageUrl: _image != null ? _image!.path : 'assets/logo.png',
        userNickname: _authManager.currentUserName ?? 'Unknown',
        tag1: int.parse(_tag1InputText.text),
        tag2: int.parse(_tag2InputText.text),
        title: _titleInputText.text,
        maxPeople: int.parse(_maxInputText.text),
        meetingDate: DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
        openTalkLink: _opentalkInputText.text,
        createDate: null,
        location: _locationInputText.text,
        mainText: _textEditingInputText.text,
      );
      await widget.unionViewModel.createUnionMeeting(newMeeting);
      widget.onMeetingCreated(newMeeting);
    }

    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: RootPage(authManager: _authManager, initialIndex: 2),
        type: PageTransitionType.rightToLeftWithFade,
        duration: Duration(milliseconds: 300),
      ),
          (Route<dynamic> route) => false,
    );
  }

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
                  _timeInputText.text.isEmpty ||
                  _locationInputText.text.isEmpty ||
                  _maxInputText.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(' 모든 항목에 입력해주세요.'),
                    backgroundColor: Constants.primaryColor,
                    duration: Duration(seconds: 1),
                  ),
                );
                return;
              }
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
                          onPressed: () async {
                            if (_opentalkInputText.text.isEmpty ||
                                _textEditingInputText.text.isEmpty ||
                                _tag1InputText.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(' 모든 항목에 입력해주세요.'),
                                  backgroundColor: Constants.primaryColor,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _isLoading = true; // 버튼을 눌렀을 때 대기 상태로 설정
                            });

                            await _createMeeting();
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
              '모임 시간',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onTap: () {
                _showTimePicker(context);
              },
              readOnly: true,
              controller: _timeInputText,
              obscureText: false,
              decoration: InputDecoration(
                hintText: '모임 시간',
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
                    : Image.file(
                  _image!,
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
