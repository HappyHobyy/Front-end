import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/auth_remote_api.dart';
import 'package:hobbyhobby/Auth/user_model.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hobbyhobby/Auth/explanation.dart';
import 'package:hobbyhobby/Auth/login.dart';
import 'package:hobbyhobby/Auth/create.dart';
import 'package:flutter/cupertino.dart';
import '../DataSource/local_data_storage.dart';
import 'auth_repository.dart';
import 'package:flutter/services.dart';

class CreateDetailPage extends StatefulWidget {
  final String password;
  final String email;
  final UserType userType;
  final AuthRepository authRepository;
  final AuthManager authManager;

  const CreateDetailPage({Key? key, required this.password, required this.email, required this.userType,required this.authRepository, required this.authManager}) : super(key: key);

  @override
  State<CreateDetailPage> createState() => _CreateDetailPageState();
}

class _CreateDetailPageState extends State<CreateDetailPage> {
  late String _password;
  late String _email;
  late UserType _userType;
  var _nicknameInputText = TextEditingController();
  var _nameInputText = TextEditingController();
  var _birthInputText = TextEditingController();
  var _phoneInputText = TextEditingController();
  var _phoneAuthText = TextEditingController();
  late String phoneNum = _phoneInputText.text.replaceAll('-', '');
  late AuthRepository _authRepository;
  late AuthManager _authManager;
  DateTime? _selectedDate;
  bool _isNicknameDuplicate = false;
  late AuthRemoteApi _authRemoteApi;

  @override
  void initState() {
    super.initState();
    _authRemoteApi = AuthRemoteApi();
    _authRepository = widget.authRepository;
    _password = widget.password;
    _email = widget.email;
    _userType = widget.userType;
    _authManager = widget.authManager;
  }

  void dispose() {
    _nicknameInputText.dispose();
    _nameInputText.dispose();
    _phoneInputText.dispose();
    _birthInputText.dispose();
    _phoneAuthText.dispose();
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
  Future<void> _checkNicknameDuplicate() async {
    try {
      bool isDuplicate = await _authRemoteApi.checkNicknameDuplicate(
          _nicknameInputText.text);
      setState(() {
        _isNicknameDuplicate = isDuplicate;
      });
      if (_isNicknameDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('중복된 닉네임입니다.'),
            backgroundColor: Constants.primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('사용 가능한 닉네임 입니다.'),
            backgroundColor: Constants.primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('$error');
    }
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
                child: CreatePage(authRepository: _authRepository,authManager: _authManager),
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
                      color: _isNicknameDuplicate ? Colors.red : Colors.grey.withOpacity(0.3),
                      width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isNicknameDuplicate ? Colors.red : Constants.primaryColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: InkWell(
                    onTap: _checkNicknameDuplicate,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: _isNicknameDuplicate ? Colors.red : Constants.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '중복 확인',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                onChanged: (value) {
                  // 입력된 문자열에서 숫자만 필터링하여 새로운 문자열을 만듭니다.
                  String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), ''); // 숫자와 '-' 제거

                  // 사용자가 '-'를 추가하거나 제거할 때, 휴대폰 번호 형식을 유지합니다.
                  if (digitsOnly.length > 3 && digitsOnly.length <= 7) {
                    // 010-xxxx 형식
                    _phoneInputText.value = TextEditingValue(
                      text: '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}',
                      selection: TextSelection.collapsed(offset: '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}'.length),
                    );
                  } else if (digitsOnly.length > 7) {
                    // 010-xxxx-xxxx 형식
                    _phoneInputText.value = TextEditingValue(
                      text: '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7)}',
                      selection: TextSelection.collapsed(offset: '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 7)}-${digitsOnly.substring(7)}'.length),
                    );
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11), // 전화번호 최대 길이 제한
                ],
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
                  suffixIcon: InkWell(
                    onTap: () {
                      // 중복 확인 기능 추가
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '  인증  ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneAuthText,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ' 인증번호',
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
                    phoneNumber: phoneNum,
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
                        child: LoginPage(authRepository: _authRepository,authManager: _authManager),
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
