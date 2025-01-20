
import 'package:ecommerce/widgets/widget_icon.dart';
import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetQuantity extends StatefulWidget {
  const WidgetQuantity({super.key});

  @override
  State<WidgetQuantity> createState() => _ItemCountWidgetState();
}

class _ItemCountWidgetState extends State<WidgetQuantity> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
             GestureDetector(
                onTap:itemCount !=1 ? () => setState(() => itemCount--) : null,
                child: const WidgetIcon(
                    icon: Icons.remove_circle, color: Colors.black, size: 20),
              ),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetText(
                text: itemCount.toString(),
                color: Colors.black,
                size: 20,
                weight: FontWeight.bold),
          ],
        ),
        const SizedBox(width: 15),
        GestureDetector(
            onTap: () {
              setState(() => itemCount++);
            },
            child: const WidgetIcon(
                icon: Icons.add_circle, color: Colors.black, size: 20)),
      ],
    );
  }
}
