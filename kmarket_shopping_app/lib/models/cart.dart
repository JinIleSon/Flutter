import 'package:kmarket_shopping_app/models/product.dart';

class Cart {
  final int? cartid;
  final String? userid;
  final Product product;
  final int quantity;

  Cart({this.cartid, this.userid, required this.product, required this.quantity});



  factory Cart.fromJson(Map<String, dynamic> json){

    final product = json['product'] as Map<String, dynamic>;

    return Cart(
        cartid: json['cartid'],
        userid: json['userid'],
        product: Product.fromJson(product),
        quantity: json['quantity']
    );
  }

}