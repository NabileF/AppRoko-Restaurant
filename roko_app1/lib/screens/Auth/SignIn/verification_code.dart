// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:pinput/pinput.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roko_app1/bloc/auth_bloc/signin_bloc/signin_bloc.dart';
import 'package:roko_app1/screens/home_page.dart';
import 'package:roko_app1/shared_widgets/components/useable_functions.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String? otpVerification;
  final String? phoneNumber;
  const VerificationCodeScreen(
      {super.key, this.otpVerification, this.phoneNumber});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  TextEditingController verificationCode = TextEditingController(text: "");
  AppLocalizations? appLocalizations;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ElevatedButtonThemeData elevatedBtn = Theme.of(context).elevatedButtonTheme;
    return BlocProvider(
      create: (context) => SigninBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<SigninBloc, SigninState>(
          listener: (context, state) async {
            if (state is SigninVerified) {
              AppFunctions.showAlert(
                  context: context,
                  alertType: AlertType.success,
                  title: appLocalizations.loginVerificationSuccess,
                  dialogButtons: [
                    DialogButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      },
                    )
                  ]);
            } else if (state is SigninError) {
              // Show error message
              AppFunctions.showAlert(
                context: context,
                alertType: AlertType.error,
                title: state.error,
              );
            }
          },
          child: BlocBuilder<SigninBloc, SigninState>(
            builder: (context, state) {
              if (state is SigninLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        height: 150.0,
                        width: 150.0,
                        image: AssetImage("assets/phone.png"),
                      ),
                      Text(
                        appLocalizations.verifyPhoneNumber,
                        style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        appLocalizations
                            .verificationCodeAlert(widget.phoneNumber!),
                        style: textTheme.labelMedium!.copyWith(
                          fontSize: 17.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
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
                        height: 40.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: elevatedBtn.style!.copyWith(),
                            onPressed: () async {
                              context.read<SigninBloc>().add(GetOTPVerification(
                                  verificationId: widget.otpVerification!,
                                  verificationCode: verificationCode.text));
                            },
                            child: Text(appLocalizations.login)), //
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.codeReceiveFailed,
                            style: const TextStyle(fontSize: 10),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              appLocalizations.supportContact,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      )
                    ],
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
