import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hobbyhobby/Auth/login.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _emailInputText = TextEditingController();
  final _passInputText = TextEditingController();

  @override
  void dispose() {
    _emailInputText.dispose();
    _passInputText.dispose();
    super.dispose();
  }

  @override
  bool _isLoading = false;
  final bool _loginFailed = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: const LoginPage(),
                  type: PageTransitionType.leftToRightWithFade,
                  duration: const Duration(milliseconds: 300),
                ),
              );
          },
        ),
        title: const Row(
          children: [
            SizedBox(width: 45),
            Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: const Column(
                  children: [
                    Text(
                      '귀하의 이메일로',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '비밀번호 재설정 메일을 전송합니다.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ]
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailInputText,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ' Email',
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
              const SizedBox(height: 100),
              InkWell(
                onTap: () async {
                  if (_emailInputText.text.isEmpty ||
                      _passInputText.text.isEmpty) return;

                  setState(() {
                    _isLoading = true; // 버튼을 눌렀을 때 대기 상태로 설정
                  });
                  // 여기에 토큰 호출 설정
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
                    child: _isLoading ?
                    const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_emailInputText.text.isEmpty ||
                      _passInputText.text.isEmpty) return;

                  setState(() {
                    _isLoading = true; // 버튼을 눌렀을 때 대기 상태로 설정
                  });
                  // 여기에 토큰 호출 설정
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Center(
                    child: _isLoading ?
                    const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Resend to Email',
                      style: TextStyle(
                        color: Constants.primaryColor,
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