import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/root_page.dart';

class RecommendationPage extends StatelessWidget {
  final String hobby1 = '축구';
  final String hobby2 = '농구';
  final String hobby3 = '야구';

  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: '유저님에게는 ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ), // 일반 텍스트
                    children: <TextSpan>[
                      TextSpan(
                        text: hobby1, // 첫 번째 변수
                        style: TextStyle(
                          color: Constants.textColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ', ', // 일반 텍스트
                      ),
                      TextSpan(
                        text: hobby2, // 두 번째 변수
                        style: TextStyle(
                          color: Constants.textColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ',', // 일반 텍스트
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hobby3,
                      style: TextStyle(
                        color: Constants.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      '가 잘 맞을 것 같아요',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50, // 원하는 위치로 조정
            child: Center(
              child: InkWell(
                onTap: () {
                    Navigator.pop(
                      context
                    );
                },
                child: Container(
                  width: 330,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constants.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      '바로 추가하러 가기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}