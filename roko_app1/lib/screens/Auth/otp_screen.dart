// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:roko_app1/services/auth_methods.dart';

class OTPScreen extends StatefulWidget {
  String otpVerification;
  OTPScreen({super.key, required this.otpVerification});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  void initState() {
    super.initState();
  }

  final verificationCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/sign_up/verification_image.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Otp Verification',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Otp Verification Sent',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  controller: verificationCode,
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue,
                          ))),
                  errorPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.red,
                          ))),
                  onCompleted: (value) {
                    setState(() {
                      verificationCode.text = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: ElevatedButton(
                    onPressed: () {
                      AuthMethods().verifyOTP(widget.otpVerification,
                          verificationCode.text, context);
                    },
                    child: Text(
                      'Verify',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'code Receive Failed',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black38),
                      children: [
                        const TextSpan(text: "\t \t"),
                        TextSpan(
                            text: 'otp Verification Resend',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 15))
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
