import 'package:flutter/material.dart';

class WidgetIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const WidgetIcon(
      {super.key, required this.icon, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
