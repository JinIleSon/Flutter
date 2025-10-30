import 'package:ch07/user2/user2_service.dart';
import 'package:flutter/material.dart';

class User1Register extends StatefulWidget{
  const User1Register({super.key});

  @override
  State<StatefulWidget> createState() => _User1RegisterState();

}

class _User1RegisterState extends State<User1Register>{

  final _formKey = GlobalKey<FormState>();

  final _useridController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User1 등록'),),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _useridController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '아이디 입력'
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}