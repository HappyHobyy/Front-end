import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/Union/create_union.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:page_transition/page_transition.dart';


class UnionPage extends StatefulWidget {
  const UnionPage({super.key});

  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '모임',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
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
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                height: 600,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      const SizedBox(height: 30, width: 10,),
                                      Text(
                                        '약관 및 주의사함',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                              const SizedBox(height: 30),
                              InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CreateUnion()),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Constants.primaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: Center(
                                    child: Text(
                                      '동의하기',
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
                        )
                    )
                  );
                }),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget> [
            Tab(text : '연합 모임'),
            Tab(text : '단일 모임'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(
            padding: EdgeInsets.all(0),
            children: [
              Container(
                height: 30,
                width: 350,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  child: Text('+ 태그 추가하기',
                      style: TextStyle(
                          fontSize: 11,
                      ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                              title: const Text(
                                '태그',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ),
                          body: Center(),
                        );
                      }),
                    );
                  },
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text('1-1'),
                ),
                title: Text('연합 모임 예시_1'),
                subtitle: Row(
                  children: [
                    const SizedBox(width: 0,),
                    Text('풋살킹'),
                    const SizedBox(width: 20,),
                    Icon(
                      Icons.account_circle_sharp,
                      size: 15,
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      '# 풋살',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      '# 사진',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text('09:41'),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Item1-1')),
                        body: Center(),
                      );
                    }),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text('1-2'),
                ),
                title: Text('Item1-2'),
                subtitle: Text('Item description'),
                trailing: Text('date'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Item1-2')),
                        body: Center(),
                      );
                    }),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text('1-3'),
                ),
                title: Text('Item1-3'),
                subtitle: Text('Item description'),
                trailing: Text('date'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Item1-3')),
                        body: Center(),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
          ListView(
            padding: EdgeInsets.all(0),
            children: [
              Container(
                height: 30,
                width: 350,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  child: Text('+ 태그 추가하기',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text(
                              '태그',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          body: Center(),
                        );
                      }),
                    );
                  },
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text('2-1'),
                ),
                title: Text('Item2-1'),
                subtitle: Text('Item description'),
                trailing: Text('date'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Item2-1')),
                        body: Center(),
                      );
                    }),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
