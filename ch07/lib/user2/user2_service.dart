import 'dart:convert';

import 'package:ch07/user2/user2.dart';
import 'package:http/http.dart' as http;

class User1Service  {
  static const String baseUrl = 'http://10.0.2.2:8080/ch08';

  Future<List<User1>> getUsers() async{
    try{

      final response = await http.get(Uri.parse('$baseUrl/user1'));

      if (response.statusCode == 200){
        List<dynamic> jsonList = json.decode(response.body);

        return jsonList.map((json) => User1.fromJson(json)).toList();
      }else{
        throw Exception('사용자 목록을 불러오는데 실패했습니다');
      }
    }catch(e){
      throw Exception('네트워크 에러 : $e');
    }
  }

  Future<User1> getUser(String userid) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user1/$userid'));

      if (response.statusCode == 200){
        return User1.fromJson(json.decode(response.body));
      }else {
        throw Exception('사용자를 찾을 수 없습니다');
      }
    }catch(e){
      throw Exception('네트워크 에러: $e');
    }
  }

  Future<User1> postUser(User1 user1) async {
    try {

      final response = await http.post(
        Uri.parse('$baseUrl/user1'),
        headers: {'Content-Type' : 'application/json'},
        body: json.encode(user1.toJson())
      );

      if (response.statusCode == 201) {
        return User1.fromJson(json.decode(response.body));
      }else {
        throw Exception('사용자 생성에 실패');
      }

    }catch(e){
      throw Exception('네트워크 에러: $e');
    }
  }

  Future<User1> updateUser(User1 user1) async {
    try{

      final response = await http.put(
        Uri.parse('$baseUrl/user1'),
        headers: {'Content-type' : 'application/json'},
        body: json.encode(user1.toJson())
      );

      if (response.statusCode == 200) {
        return User1.fromJson(json.decode(response.body));
      }else{
        throw Exception('사용자 수정에 실패했습니다');
      }

    }catch(e){
      throw Exception('네트워크 에러 : $e');
    }
  }

  Future<void> deleteUser(String userid) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/user1/$userid'));

      if (response.statusCode != 200){
        throw Exception('사용자 삭제에 실패했습니다');
      }

    }catch(e){
      throw Exception('네트워크 에러: $e');
    }
  }
}