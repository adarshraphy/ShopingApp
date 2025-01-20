import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 150),
          Center(
            child: WidgetText(
              text: "Verification",
              color: Colors.black,
              size: 25,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: WidgetText(
              text: "Enter the code sent to your number",
              color: Colors.grey,
              size: 14,
              weight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: _pinController,
              focusNode: _focusNode,
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (String verificationCode) {
              },
              onChanged: (code) {
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: Colors.red,
                  ),
                ],
              ),
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(30, 60, 87, 1),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
