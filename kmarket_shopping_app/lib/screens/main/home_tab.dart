import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
  
}

class _HomeTabState extends State<HomeTab>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈'),),
      body: Column(
        children: [
          Text('홈 메인')
        ],
      ),
    );
  }
  
}