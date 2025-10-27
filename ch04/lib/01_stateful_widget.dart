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
        body: StatefulTest(),
      ),
    );
  }
}

// Stateful 위젯은 상태를 통해 화면을 갱신하는 동적 위젯
class StatefulTest extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _StatefulTestState();


}

class _StatefulTestState extends State<StatefulTest> { // StatelessWidget은 상태(속성)가 변경되어도 화면이 다시 갱신되지 않음.

  // 상태 속성
  int counter = 0;

  void _increment(){

    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('카운터 : $counter', style: TextStyle(fontSize: 24),),
        ElevatedButton(
            onPressed: _increment,
            child: const Text('카운트')
        )
      ],
    );
  }

}