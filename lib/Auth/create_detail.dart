import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/user_model.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hobbyhobby/Auth/explanation.dart';
import 'package:hobbyhobby/Auth/login.dart';
import 'package:hobbyhobby/Auth/create.dart';
import 'package:flutter/cupertino.dart';

import 'auth_repository.dart';

class CreateDetailPage extends StatefulWidget {
  final String password;
  final String email;
  final UserType userType;

  const CreateDetailPage({Key? key, required this.password, required this.email, required this.userType}) : super(key: key);

  @override
  State<CreateDetailPage> createState() => _CreateDetailPageState();
}

class _CreateDetailPageState extends State<CreateDetailPage> {
  late String _password;
  late String _email;
  late UserType _userType;
  var _emailInputText = TextEditingController();
  var _passInputText = TextEditingController();
  var _nicknameInputText = TextEditingController();
  var _nameInputText = TextEditingController();
  var _birthInputText = TextEditingController();
  var _phoneInputText = TextEditingController();
  late AuthRepository _authRepository;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _password = widget.password;
    _email = widget.email;
    _userType = widget.userType;
    _authRepository = AuthRepository();
  }

  void dispose() {
    _emailInputText.dispose();
    _passInputText.dispose();
    _nicknameInputText.dispose();
    _nameInputText.dispose();
    _phoneInputText.dispose();
    _birthInputText.dispose();
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
                _birthInputText.text =
                    "${_selectedDate!.year}.${_selectedDate!.month}.${_selectedDate!.day}";
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

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: CreatePage(),
                type: PageTransitionType.leftToRightWithFade,
                duration: Duration(milliseconds: 300),
              ),
            );
          },
        ),
        title: Row(
          children: [
            const SizedBox(width: 80),
            Text(
              '회원가입',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              TextField(
                controller: _nicknameInputText,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ' 닉네임',
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
              const SizedBox(height: 10),
              TextField(
                controller: _nameInputText,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ' 이름',
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
              const SizedBox(height: 10),
              TextField(
                onTap: () {
                  _showDatePicker(context);
                },
                readOnly: true,
                controller: _birthInputText,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ' 생년월일',
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
              const SizedBox(height: 10),
              TextField(
                controller: _phoneInputText,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ' 휴대폰 번호',
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
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  if (_nicknameInputText.text.isEmpty ||
                      _nameInputText.text.isEmpty ||
                      _birthInputText.text.isEmpty ||
                      _phoneInputText.text.isEmpty) {
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
                  User user = User.withUserRegister(
                    userEmail: _email,
                    userType: _userType,
                    userNickName: _nicknameInputText.text,
                    phoneNumber: int.parse(_phoneInputText.text),
                    userName: _nameInputText.text,
                    // 문자열을 정수로 변환
                    birth: _birthInputText.text,
                    password: _password,
                    gender: Gender.MAN,
                    nationality: Nationality.DOMESTIC,
                  );
                  try {
                    await _authRepository.postDefaultRegister(user);
                    // 회원가입 요청 완료 후 페이지 전환
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: LoginPage(),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } catch (error) {
                    if (error.toString() == 'USER_EMAIL_DUPLICATED') {
                      // 에러 처리 해주세용!
                    }
                    setState(() {
                      _isLoading = false; // 에러 발생 시 대기 상태 해제
                      _loginFailed = true; // 로그인 실패 상태로 설정
                    });
                    print('Error during registration: $error');
                  }
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Center(
                    child: _isLoading
                        ? SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            '회원가입',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
