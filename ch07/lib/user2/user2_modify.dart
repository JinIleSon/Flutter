import 'package:ch07/user1/user1_modify.dart';
import 'package:ch07/user2/user2.dart';
import 'package:ch07/user2/user2_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class User1Modify extends StatefulWidget {

  final String userid;

  const User1Modify({super.key, required this.userid});

  @override
  State<StatefulWidget> createState() => _User1ModifyState();


}

class _User1ModifyState extends State<User1Modify> {

  final service = User1Service();

  final _formKey = GlobalKey<FormState>();
  final _useridController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _ageController = TextEditingController();

  String message = '';

  @override
  void initState(){
    super.initState();

    _loadUser();
  }

  Future<void> _loadUser() async {

    try {
      User1 user = await service.getUser(widget.userid);

      setState(() {
        _useridController.text = user.userid;
        _nameController.text = user.name;
        _birthController.text = user.birth;
        _ageController.text = user.age.toString();
      });
    }catch(e){
      _showDialog('조회 실패', '조회를 실패.. $e');
    }
  }

  Future<void> _submitForm() async {

    if(!_formKey.currentState!.validate()) return;

    User1 inputUser = User1(
        userid: _useridController.text,
        name: _nameController.text,
        birth: _birthController.text,
        age: int.tryParse(_ageController.text) ?? 0
    );

    try {

      User1 savedUser = await service.updateUser(inputUser);

      _showDialog('수정', '수정완료!');

      Navigator.pop(context, savedUser);

    }catch(e) {
      setState(() {
        message = '에러 발생 $e';
      });
    }

  }

  Future<void> _showDialog(String title, String message) async{
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {Navigator.pop(context);},
                child: const Text('OK'))
          ],
        )
    );
  }

  Future<void> _selectBirth() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _birthController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User1 수정'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _useridController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'User ID'),
                  validator: (value) =>
                  value!.isEmpty ? 'User ID를 입력하세요' : null,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: '이름'),
                  validator: (value) =>
                  value!.isEmpty ? '이름 입력하세요' : null,
                ),
                TextFormField(
                  controller: _birthController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: '생년월일 (날짜 선택)',),
                  onTap: _selectBirth,
                  validator: (value) =>
                  value!.isEmpty ? '생년월일 입력' : null,
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(labelText: '나이 (숫자만 입력)'),
                  validator: (value) =>
                  value!.isEmpty ? '나이 입력' : null,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('취소하기')),
                    ElevatedButton(
                        onPressed: (){
                          _submitForm();
                        },
                        child: const Text('수정하기'))
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }

}