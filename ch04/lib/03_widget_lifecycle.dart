/*
  이름: 손진일
  날짜: 2025/10/27
  내용: State lifecycle

 */

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('01.Stateful 위젯 실습',)
        ),
        body: Parentwidget(),
      ),
    );
  }
}

// Stateful 위젯은 상태를 통해 화면을 갱신하는 동적 위젯
class Parentwidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ParentwidgetState();


}

class _ParentwidgetState extends State<Parentwidget> {

  // 상태
  int counter = 0;
  bool showChild = true;

  void _increment(){

    setState(() {
      counter++;
    });
  }

  void _toggleChild(){
    setState(() {
      showChild = !showChild;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        showChild
            ? Text('ChildWidget 생성', style: TextStyle(fontSize: 26),)
            : Text('ChildWidget 제거', style: TextStyle(fontSize: 26),),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('ChildWidget 상태 변경')
        ),
          ElevatedButton(
            onPressed: _toggleChild,
            child: const Text('ChildWidget 생성/제거')
            )
      ],
    );
  }

}