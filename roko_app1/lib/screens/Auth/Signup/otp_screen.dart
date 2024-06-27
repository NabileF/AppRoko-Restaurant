// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:pinput/pinput.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roko_app1/bloc/auth_bloc/signup_bloc/signup_bloc.dart';
import 'package:roko_app1/screens/Auth/Signup/restaurant_info.dart';
import 'package:roko_app1/shared_widgets/components/useable_functions.dart';

class OTPScreen extends StatefulWidget {
  String otpVerification;
  OTPScreen({
    super.key,
    required this.otpVerification,
  });

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
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupVerified) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FinalStepScreen(),
              ));
            } else if (state is SignupError) {
              // Show error message
              AppFunctions.showAlert(
                context: context,
                alertType: AlertType.error,
                title: state.error,
              );
            }
          },
          child: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              if (state is SignupLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage(
                              "assets/sign_up/verification_image.jpg"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          appLocalizations.otpVerification,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          appLocalizations.otpVerificationSent,
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
                              context.read<SignupBloc>().add(GetOTPVerification(
                                  verificationId: widget.otpVerification,
                                  verificationCode: verificationCode.text));
                            },
                            child: Text(
                              appLocalizations.otpVerificationVerify,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RichText(
                          text: TextSpan(
                              text: appLocalizations.codeReceiveFailed,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black38),
                              children: [
                                const TextSpan(text: "\t \t"),
                                TextSpan(
                                    text:
                                        appLocalizations.otpVerificationResend,
                                    style: const TextStyle(
                                        color: Colors.blue, fontSize: 15))
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
