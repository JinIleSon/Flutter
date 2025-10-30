import 'dart:convert';

import 'package:kmarket_shopping_app/models/member.dart';
import 'package:http/http.dart' as http;


class MemberService {

  final String baseUrl = 'http://10.0.2.2:8090/ch09';

  Future<void> login() async {
    return;
  }

  Future<Map<String, dynamic>> register(Member member) async {

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/user/register'),
          headers: {'Content-Type': "application/json"},
          body: json.encode(member.toJson())
      );

      if(response.statusCode == 200){
        // savedUser 반환
        return jsonDecode(response.body);
      }else {
        throw Exception('response.statusCode : ${response.statusCode}');
      }

    }catch(e){
      throw Exception('네트워크 오류 : $e');
    }
  }



}