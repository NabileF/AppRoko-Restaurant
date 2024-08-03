import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:roko_app1/app_colors/app_colors.dart';
import 'package:roko_app1/app_manager/l10n.dart';
import 'package:roko_app1/bloc/auth_bloc/signin_bloc/signin_bloc.dart';
import 'package:roko_app1/bloc/auth_bloc/signup_bloc/signup_bloc.dart';
import 'package:roko_app1/firebase_options.dart';
import 'package:roko_app1/screens/Auth/intro_screen.dart';
import 'package:roko_app1/screens/supplier/create_supplier_account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider
        .playIntegrity, // For Android (use .playIntegrity for production)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFAF9F6),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
            color: const Color(0xFFFAF9F6),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  maximumSize: WidgetStateProperty.all<Size>(
                    const Size.fromWidth(double.infinity),
                  ),
                  iconColor: WidgetStateProperty.all<Color>(
                    Colors.white,
                  ),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(AppColors.lightBlue),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))))),
        ),
        // home: MultiBlocProvider(
        //   providers: [
        //     BlocProvider<SigninBloc>(create: (context) => SigninBloc()),
        //     BlocProvider<SignupBloc>(create: (context) => SignupBloc())
        //   ],
        //   child: const IntroScreen(),
        // ),
      home: CreateSupplierAccountScreen(),
    );
  }
}
