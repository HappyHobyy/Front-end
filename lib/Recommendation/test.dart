import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/Recommendation/animation.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  final List<int?> _selectedAnswers = List.filled(12, null); // Track selected answers

  // Define the list of questions
  final List<Question> _questions = [
    Question(
      text: '여가 시간이 생겼을 때',
      answers: ['집에서 혼자 쉬는게 최고야!', '나가서 사람들과 어울릴거야!'],
    ),
    Question(
      text: '낯선 사람들과 모임에 참여한다면?',
      answers: ['집에 빨리 가고 싶어..', '빨리 친해지고 싶어!!'],
    ),
    Question(
      text: '새로운 취미를 고를 때',
      answers: ['나 혼자 즐길 수 있는 취미', '많은 사람들과 만날 수 있는 취미'],
    ),
    Question(
      text: '비행기를 탔는데 갑자기 흔들릴 때',
      answers: ['어라 왜 흔들리지? 무서워!', '승무원이 알려준 대피 요령이 뭐였지?'],
    ),
    Question(
      text: '음악을 들을 때 더 좋아하는 것은?',
      answers: ['멜로디', '가사'],
    ),
    Question(
      text: '친구에게 요리를 해준다면?',
      answers: ['유튜브에서 봤던 레시피 그대로 정량을 딱 맞춘다', '내 손 맛 알지? 감으로 넣는다'],
    ),
    Question(
      text: '나 우울해서 화분 샀어..',
      answers: ['어떤 화분 샀어?', '무슨 일 있어?'],
    ),
    Question(
      text: '친구가 약속 시간보다 늦게 왔을 때',
      answers: ['이유를 들으면 풀린다', '사과를 하면 풀린다'],
    ),
    Question(
      text: '고민 상담을 해준다면?',
      answers: ['처한 문제에 대한 해결책을 말해준다', '최대한 오래 고민을 들어준다'],
    ),
    Question(
      text: '친구들과 함께 여행을 갔을 때',
      answers: ['어디 갈까?', '일단 나가서 생각하자!'],
    ),
    Question(
      text: '과제가 생겼을 때',
      answers: ['미리미리 계획을 세운다', '데드라인에 가까워지면 한다'],
    ),
    Question(
      text: '친구와 약속이 있을 때',
      answers: ['약속 시간보다 일찍 도착한다.', '조금 늦게 도착하거나 시간을 조정한다.'],
    ),
  ];

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _selectAnswer(int questionIndex, int answerIndex) {
    setState(() {
      _selectedAnswers[questionIndex] = answerIndex + 1; // Store 1 or 2 instead of 0 or 1
    });
  }

  void _showIncompleteAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '모든 항목에 답변해주세요.',
          style: TextStyle(
            fontSize: 20,
          ),
          ),
          actions: [
            TextButton(
              child: const Text(
                  '확인',
              style: TextStyle(
                fontSize: 16,
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentQuestionIndex + 1}/${_questions.length}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return QuestionWidget(
                  question: _questions[index],
                  selectedAnswerIndex: _selectedAnswers[index],
                  onSelectAnswer: (answerIndex) {
                    _selectAnswer(index, answerIndex);
                  },
                );
              },
            ),
          ),
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Colors.grey[300],
            color: Constants.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Row(
              mainAxisAlignment: _currentQuestionIndex == 0
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // 이전 버튼은 회색으로 표시
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(80, 30),
                    ),
                    child: Text(
                      '이전',
                      style: TextStyle(
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                if (_currentQuestionIndex < _questions.length - 1)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(80, 30),
                    ),
                    child: const Text(
                      '다음',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (_currentQuestionIndex == _questions.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedAnswers.contains(null)) {
                        _showIncompleteAlert(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimationPage(answers: _selectedAnswers)
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(80, 30),
                    ),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> answers;

  Question({required this.text, required this.answers});
}

class QuestionWidget extends StatelessWidget {
  final Question question;
  final int? selectedAnswerIndex;
  final Function(int) onSelectAnswer;

  const QuestionWidget({
    required this.question,
    required this.selectedAnswerIndex,
    required this.onSelectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            question.text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 180),
          ...question.answers.asMap().entries.map((entry) {
            int index = entry.key;
            String answer = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onSelectAnswer(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedAnswerIndex == index + 1
                        ? Constants.primaryColor
                        : Constants.primaryColor.withOpacity(0.25),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    answer,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
