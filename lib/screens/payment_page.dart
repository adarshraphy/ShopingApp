
import 'dart:async';

import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../widgets/widget_bottomnav.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  void initState() {
    super.initState();
    Timer(Duration(seconds:2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    WidgetBottomnav(index: 0),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Lottie.asset('assets/images/payment_animation.json',
                  width: 500, height:400),
            ),
          ),
          Center(child: WidgetText(text: "Yay! Order Received", color: Colors.black, size: 20, weight: FontWeight.bold))
        ],
      ),
    );
  }
}
