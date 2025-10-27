/*
  날짜 : 2025/10/27
  이름 : 손진일
  내용 : ListView 위젯 실습하기
 */

import 'package:flutter/material.dart';

void main(){
  // ListView 기본
  // runApp(ListViewTest1());

  // ListView.builder 실습
  runApp(ListViewTest2());

}

class ListViewTest1 extends StatelessWidget {
  const ListViewTest1({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('01.ListView 위젯 실습')),
        body: ListView(
          children: [
            for(int i=1; i<=10; i++)
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(
                    width: 1,
                    color: Colors.black
                  )
                ),
                child: Text('${i}번째 항목'),
              ),
            ],
        ),
      ),
    );
  }
}

class ListViewTest2 extends StatelessWidget {
  const ListViewTest2({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> personList = ['김유신', '김춘추', '장보고', '강감찬', '이순신'
    , '정약용', '안중근', '유관순', '안창호', '김구'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('02.ListView.builder 위젯 실습')),
        body: ListView.builder(
          itemCount: personList.length,  // 목록에 출력할 총 아이템 갯수
          itemBuilder: (context, index){ // 인덱스를 기반으로 각 아이템 위젯 생성
            return Container(            // ListView.builder는 아이템 갯수가 많거나 동적으로 위젯을 생성해서 메모리 자원을 효율적으로 사용, Lazy Loading으로 성능 극대화
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  )
              ),
              child: Text('${personList[index]}'),
            );
          },
        ),
      ),
    );
  }
}