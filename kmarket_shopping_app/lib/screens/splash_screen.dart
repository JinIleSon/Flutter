import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/screens/main/main_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();

    // 3초 후 메인 탭 이동
    Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainTabScreen())
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            const SizedBox(height: 40,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

}