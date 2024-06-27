import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:roko_app1/bloc/auth_bloc/signup_bloc/signup_bloc.dart';
import 'package:roko_app1/screens/Auth/SignIn/login_screen.dart';
import 'package:roko_app1/screens/Auth/Signup/signup_first_screen.dart';
import 'package:roko_app1/shared_widgets/components/useable_functions.dart';

import '../../app_colors/app_colors.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ElevatedButtonThemeData _elevatedBtn =
        Theme.of(context).elevatedButtonTheme;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // Some gradient color
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1a2980), Color(0xff26d0ce)],
              stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    appLocalizations.intro,
                    textAlign: TextAlign.center,
                    style: _textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    child: Text(
                      appLocalizations.appDescription,
                      maxLines: 2,
                      style: _textTheme.headlineMedium!
                          .copyWith(fontSize: 15, color: Colors.grey[400]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Image(
                    image: AssetImage("assets/intro/img.png"),
                    height: 297,
                    width: 215,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 292,
                    height: 46,
                    child: ElevatedButton(
                      style: _elevatedBtn.style,
                      onPressed: () {
                        AppFunctions.navigateTo(context, LoginScreen());
                      },
                      child: Text(
                        appLocalizations.login,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 292,
                    height: 46,
                    child: ElevatedButton(
                      style: _elevatedBtn.style?.copyWith(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(AppColors.white)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SignupBloc(),
                            child: SignupFirstScreen(),
                          ),
                        ));
                      },
                      child: Text(
                        appLocalizations.signUp,
                        style: _textTheme.titleSmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 31.0,
                    width: 263,
                    child: Text(
                      appLocalizations.terms,
                      softWrap: true,
                      style: _textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
