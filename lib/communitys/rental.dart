import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:intl/intl.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          '홈카페',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
          child: Column(
            children: [
              body1(context),
              SizedBox(height: 20), // Add some space between the two containers
              body2(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget body1(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail1Page()),
        );
      },
      child: Container(
        width: double.infinity, // Container width to fill parent width
        height: 470, // Set a specific height if needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/홈카페2.png',
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '홈카페 입문자 패키지',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      '24H',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '50,000',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body2(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail2Page()),
        );
      },
      child: Container(
        width: double.infinity, // Container width to fill parent width
        height: 470, // Set a specific height if needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/홈카페1.png'),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '홈카페 중급자 패키지',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      '24H',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '100,000',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Detail1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 26, right: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 290, // Set the desired height
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/홈카페2.png',
                    fit: BoxFit
                        .cover, // Ensures the image covers the entire container
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '홈카페 입문자 패키지',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Row(
                children: [
                  Text(
                    '24H',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '50,000원',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Text(
                ' 상품설명',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: 400,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Text(
                '  1. 에스프레소 머신: 딜리코 CRM3605S',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 58mm 포터필더 규격과 3 Way 밸브, 15BAR 펌프',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 압력, 추출시간 타이머 등을 제공하여 필수 덕목을 모',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 두 갖춘 입문자용 머신 (포터필터, 탬퍼 포함)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '  2. 그라인더: ITOP 03(하이퍼노바 울트라 7코어)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 코니컬 버의 깔끔함과 묵직한 바디감, 달콤함을 잘',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 살려 입문자들의 입맛에 딱 맞춤 가성비 그라인더',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '  3. 저울: 타임모어 나노',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 아카이아 펄의 호환 저울로 이름을 떨친 타임모어',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 나노. 아카이아보다 작은 사이즈로 머신에 바로 올릴',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 수 있어 더욱 많은 사랑을 받은 제품',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 30.0, left: 25, right: 25, top: 16),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return RentalBottomSheet(rentalRate: 50000);
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.textColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text('대여하기',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}

class Detail2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 26, right: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400, // Set the desired height
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/홈카페1.png',
                    fit: BoxFit
                        .cover, // Ensures the image covers the entire container
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '홈카페 중급자 패키지',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Row(
                children: [
                  Text(
                    '24H',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '100,000원',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Text(
                ' 상품설명',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: 400,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Text(
                '  1. 에스프레소 머신: 가찌아 클래식 에보 프로',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 에스프레소 머신 필수 덕목은 기본. 안정적인 연속',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 추출을 위한 PID까지. 제품 변화는 없어도 꾸준히 사',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 랑받는 중급자용 머신 (포터필터, 탬퍼 포함)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '  2. 그라인더: 세테 270',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 코니컬 버를 사용했지만 플랫버의 맛까지 구현? 초',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 상급자도 잊지 못해 재구매하는 중급자용 그라인더.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '  3. 저울: 타임모어 나노',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 아카이아 펄의 호환 저울로 이름을 떨친 타임모어',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 나노. 아카이아보다 작은 사이즈로 머신에 바로 올릴',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                ' 수 있어 더욱 많은 사랑을 받은 제품',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 30.0, left: 25, right: 25, top: 16),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return RentalBottomSheet(rentalRate: 100000);
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.textColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text('대여하기',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}

class RentalBottomSheet extends StatefulWidget {
  final int rentalRate;

  RentalBottomSheet({required this.rentalRate});

  @override
  _RentalBottomSheetState createState() => _RentalBottomSheetState();
}

class _RentalBottomSheetState extends State<RentalBottomSheet> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);
  late int rentalRate;

  @override
  void initState() {
    super.initState();
    rentalRate = widget.rentalRate;
  }

  void _showCupertinoDatePicker(BuildContext context, bool isStartDate) {
    final DateTime minimumDate = DateTime(2024, 1, 1);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            initialDateTime: isStartDate ? selectedStartDate : selectedEndDate,
            minimumDate: minimumDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                if (isStartDate) {
                  selectedStartDate = newDateTime.isBefore(minimumDate)
                      ? minimumDate
                      : newDateTime;
                  selectedEndDate = selectedStartDate.add(Duration(days: 1));
                } else {
                  selectedEndDate = newDateTime.isBefore(selectedStartDate)
                      ? selectedStartDate.add(Duration(days: 1))
                      : newDateTime;
                }
              });
            },
          ),
        );
      },
    );
  }

  void _showCupertinoTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            initialDateTime: DateTime(
              2020,
              1,
              1,
              selectedTime.hour,
              0,
            ),
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                selectedTime = TimeOfDay(
                  hour: newDateTime.hour,
                  minute: 0,
                );
              });
            },
          ),
        );
      },
    );
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final period = timeOfDay.period == DayPeriod.am ? '오전' : '오후';
    final hours = (timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod)
        .toString()
        .padLeft(2, '0');
    return "$period $hours:00";
  }

  String _formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDateTime = DateTime(
      selectedStartDate.year,
      selectedStartDate.month,
      selectedStartDate.day,
      selectedTime.hour,
      0,
    );

    DateTime endDateTime = DateTime(
      selectedEndDate.year,
      selectedEndDate.month,
      selectedEndDate.day,
      selectedTime.hour,
      0,
    );

    final rentalPeriodInHours = endDateTime.difference(startDateTime).inHours;
    final rentalCost = ((rentalPeriodInHours / 24) * rentalRate)
        .toInt(); // Example cost calculation based on 24 hours
    final formattedRentalCost = _formatCurrency(rentalCost);

    return FractionallySizedBox(
      heightFactor: 0.45,
      widthFactor: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  '대여시간 선택하기',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '대여일',
                    style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => _showCupertinoDatePicker(context, true),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        "${selectedStartDate.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showCupertinoTimePicker(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        _formatTimeOfDay(selectedTime),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: 360,
              color: Colors.grey,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '반납일',
                    style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => _showCupertinoDatePicker(context, false),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        "${selectedEndDate.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showCupertinoTimePicker(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        _formatTimeOfDay(selectedTime),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: 360,
              color: Colors.grey,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${rentalPeriodInHours}시간',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${formattedRentalCost}원',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {
                // Add your rental functionality here
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 130),
                child: Text(
                  '대여하기',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.textColor,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
