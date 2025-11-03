
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {

  final String baseUrl = 'http://10.0.2.2:8090/ch09';

  Future<void> fetchProductList(int category, int pg) async {

    try{

      final response = await http.get(Uri.parse('$baseUrl/product?category=$category&pg=$pg'));

      if(response.statusCode == 200) {

        final jsonData = jsonDecode(response.body);
      }

    }catch(err){

    }

    return null;
  }
}