import 'dart:developer';

import 'package:ch07/user1/user1.dart';
import 'package:ch07/user1/user1_modify.dart';
import 'package:ch07/user1/user1_register.dart';
import 'package:ch07/user1/user1_service.dart';
import 'package:flutter/material.dart';

class User1List extends StatefulWidget {
  const User1List({super.key});

  @override
  State<StatefulWidget> createState() => _User1ListState();

}

class _User1ListState extends State<User1List> {

  late Future<List<User1>> futureUserList;

  final service = User1Service();

  @override
  void initState(){
    super.initState();

    futureUserList = service.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User1 목록'),),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await Navigator.of(context).push(
                MaterialPageRoute(builder:
                (context) => User1Register()
                )
            );
            if (!mounted) return;
            setState(() {
              futureUserList = service.getUsers();
            });
          },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: futureUserList,
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text('에러 발생 : ${snapshot.error}');
            }

            final userList = snapshot.data!;

            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name[0]),
                      ),
                      title: Text('${user.name}(${user.userid})'),
                      subtitle: Text('${user.age}세(${user.birth})'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async{
                                final modifiedUser = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => User1Modify(userid: user.userid)
                                  )
                                );

                                if (modifiedUser != null){
                                  log('modify 성공');
                                  setState(() {
                                    futureUserList = service.getUsers();
                                  });
                                }
                              },
                              icon: Icon(Icons.edit, color: Colors.blue,)
                          ),
                          IconButton(
                              onPressed: () async {
                                final confirm = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('삭제 확인'),
                                      content: Text('${user.name}(${user.userid}) 을 삭제하시겠습니까?'),
                                      actions: [
                                        TextButton(
                                            onPressed: (){Navigator.pop(context, false);},
                                            child: const Text('취소')),
                                        TextButton(
                                            onPressed: (){Navigator.pop(context,true);},
                                            child: const Text('삭제'))
                                      ],
                                    )
                                );

                                if (confirm != true) return;

                                await service.deleteUser(user.userid);

                                setState(() {
                                  futureUserList = service.getUsers();
                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.red,))
                        ],
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }

}