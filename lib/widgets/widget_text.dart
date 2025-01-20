import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TextOverflow? overflow;

  const WidgetText(
      {super.key,
      required this.text,
      required this.color,
      required this.size,
      required this.weight, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,overflow:overflow ,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
