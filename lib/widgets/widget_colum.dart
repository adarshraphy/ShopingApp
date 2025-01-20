import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetColum extends StatelessWidget {
  final String productimage;
  final String text;
  WidgetColum({super.key, required this.productimage, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Column(
        children: [
          Image.asset(productimage),
          SizedBox(height: 5,),
          WidgetText(
              text: text, color: Colors.black, size: 15, weight: FontWeight.bold)
        ],
      ),
    );
  }
}
