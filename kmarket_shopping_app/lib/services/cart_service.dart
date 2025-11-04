import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kmarket_shopping_app/config/app_config.dart';
import 'package:kmarket_shopping_app/models/cart.dart';
import 'package:kmarket_shopping_app/services/token_storage_service.dart';

class CartService {

  final TokenStorageService _tokenStorageService = TokenStorageService();

  Future<Map<String, dynamic>> addCart(int pno, int quantity) async{

    try{

      // JWT 가져오기
      final jwt = await _tokenStorageService.readToken();

      log('jwt : $jwt');

      // 전송 데이터 생성
      final jsonData = {
        "pno" : pno,
        "quantity" : quantity,
      };

      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/cart'),
        headers: {
          "Content-Type" : "application/json",
          "Authorization": "Bearer$jwt"
        },
        body: jsonEncode(jsonData)
      );

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception(response.statusCode);
      }

    }catch(err){
      throw Exception(err);
    }
  }
}