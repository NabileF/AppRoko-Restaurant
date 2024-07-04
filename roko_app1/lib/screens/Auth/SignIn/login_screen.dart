// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roko_app1/app_colors/app_colors.dart';
import 'package:roko_app1/bloc/auth_bloc/signin_bloc/signin_bloc.dart';
import 'package:roko_app1/screens/Auth/SignIn/verification_code.dart';
import 'package:roko_app1/screens/Auth/Signup/signup_first_screen.dart';
import 'package:roko_app1/screens/Auth/intro_screen.dart';
import 'package:roko_app1/screens/home_page.dart';
import 'package:roko_app1/shared_widgets/components/useable_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _phoneNumberCorrect = false;
  TextEditingController _phoneNumberController = TextEditingController();
  List<String> list = ["+212", "+1", "+99"];

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    TextTheme _textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => SigninBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<SigninBloc, SigninState>(
          listener: (context, state) {
            if (state is SigninOTPSend) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => SigninBloc(),
                  child: VerificationCodeScreen(
                      otpVerification: state.verificationId!,
                      phoneNumber: state.phoneNumber),
                ),
              ));
            } else if (state is SigninVerified) {
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
            } else if (state is SigninUserNotExist) {
              AppFunctions.showAlert(
                  context: context,
                  alertType: AlertType.error,
                  message: "Would you like to sign up?",
                  title: appLocalizations.loginVerificationError,
                  dialogButtons: [
                    DialogButton(
                        child: const Text("Sign up"),
                        onPressed: () {
                          AppFunctions.navigateToAndRemove(
                              context, const SignupFirstScreen());
                        }),
                    DialogButton(
                        onPressed: () {
                          AppFunctions.navigateToAndRemove(
                              context, const IntroScreen());
                        },
                        child: Text('Cancel')) //
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      appLocalizations.login,
                      style: _textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Image(
                      height: 150.0,
                      width: 150.0,
                      image: AssetImage("assets/login_image.png"),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      appLocalizations.phoneVerification,
                      style: _textTheme.labelMedium!.copyWith(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            setState(() {
                              _phoneNumberController.text = value;
                            });
                            if (value.length >= 9) {
                              setState(() {
                                _phoneNumberCorrect = true;
                              });
                            } else {
                              setState(() {
                                _phoneNumberCorrect = false;
                              });
                            }
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: appLocalizations.registrationHintText,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(14.0),
                              child: const Text(
                                "🇲🇦 +212",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            suffixIcon: _phoneNumberCorrect
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : null,
                          ),
                          validator: (value) {
                            var reg = RegExp(r"^\d+$");
                            if (value!.isEmpty) {
                              return appLocalizations
                                  .registrationPhoneNumberEmpty;
                            } else if (value.length < 9) {
                              return "Phone number must be 9 digit or more ";
                            } else if (!reg.hasMatch(value)) {
                              return appLocalizations
                                  .registrationPhoneNumberInvalid;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String userPhoneNumber =
                                  "+212${_phoneNumberController.text.trim()}";

                              context.read<SigninBloc>().add(GetSignIn(
                                    phoneNumber: userPhoneNumber,
                                  ));
                            }
                          },
                          child: Text(
                            appLocalizations.sendVerificationCode,
                            style: _textTheme.labelLarge!
                                .copyWith(color: AppColors.white),
                          )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
