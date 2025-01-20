import 'package:flutter/material.dart';

class WidgetButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback? onpressed;
  final Color color;
  final double iconsize;

  const WidgetButton(
      {super.key, required this.icon, this.onpressed, required this.color, required this.iconsize});

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onpressed,
      icon: widget.icon,
      color: widget.color,
      iconSize: widget.iconsize,
    );
  }
}
