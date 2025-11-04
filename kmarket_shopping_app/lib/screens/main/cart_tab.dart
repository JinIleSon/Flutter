import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/models/cart.dart';
import 'package:kmarket_shopping_app/providers/auth_provider.dart';
import 'package:kmarket_shopping_app/screens/member/login_screen.dart';
import 'package:kmarket_shopping_app/services/cart_service.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {

  late Future<List<Cart>> _futureListCart;
  
  final cartService = CartService(); 
 
  @override
  void initState() {
    super.initState();


    _futureListCart = _loadCartList();
  }
  
  Future<List<Cart>> _loadCartList() async{
    List<dynamic> jsonData = await cartService.getCarts();

    log('jsonData : $jsonData');
    
    return jsonData
                .map((json) => Cart.fromJson(json))
                .toList();
  }
  
  @override
  Widget build(BuildContext context) {

    // 아래 Consumer 위젯으로 처리
    // Provider 구독
    final authProvider = Provider.of<AuthProvider>(context);
    final isLogin = authProvider.isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<AuthProvider>(
          builder: (context, provider, child){
            return provider.isLoggedIn ? _buildCartList() : _buildLoginRequired();
          }
      )
    );
  }
  // 로그인을 하지 않을 때의 화면
  Widget _buildLoginRequired(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('장바구니는 로그인 후 이용 가능합니다.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // 로그인 화면으로 이동
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text('로그인 하러 가기'),
          ),
        ],
      ),
    );
  }

  // 로그인을 했을 때의 화면
  Widget _buildCartList(){
    return FutureBuilder<List<Cart>>(
        future: _futureListCart, 
        builder: (context, snapshot){

          final listCart = snapshot.data ?? [];
          
          return ListView.builder(
              itemCount: listCart.length,
              itemBuilder: (context, index){
                
                final cart = listCart[index];
                
                return Card(
                  child: Text('cart : ${cart.cartid}'),
                );
              }
          );
        },
    );
  }
}