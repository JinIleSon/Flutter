import 'dart:convert';

import 'package:ch07/user2/user2.dart';
import 'package:http/http.dart' as http;

class User1Service {

  static const String baseUrl = 'http://10.0.2.2:8080/ch08';

  Future<List<User1>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user1'));

      if(response.statusCode == 200){
        List<dynamic> jsonList = json.decode(response.body);

        return jsonList.map((json) => User1.fromJson(json)).toList();
      }


    }catch(e){
      throw Exception('네트워크 에러: $e');
    }
  }



}