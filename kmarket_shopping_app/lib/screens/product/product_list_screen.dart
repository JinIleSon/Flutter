import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {

  final int categoryNum;
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryNum, required this.categoryName});

  @override
  State<StatefulWidget> createState() => _ProductListScreenState();

}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.categoryName}(${widget.categoryNum}) 상품 목록'),),
      body: Column(
        children: [
          Text('상품 내용')
        ],
      ),
    );
  }

}