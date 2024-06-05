import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roko_app1/screens/Auth/otp_screen.dart';
import 'package:roko_app1/screens/home_page.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  signIn({required String phoneNumber, required BuildContext context}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        try {
          //UserCredential userCredential =
          await _auth.signInWithCredential(credential);
          /*RestaurantModel(
              restaurantId: userCredential.user!.uid,
              ownerName: ownerName,
              restaurantName: restaurantName,
              busnissHours: '',
              subscription: SubscriptionModel(),
              contactInfo: ContactInfo());*/
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        } on Exception catch (e) {
          print(e.toString());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OTPScreen(
            otpVerification: verificationId,
          ),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
        print("Timout");
      },
    );
  }

  verifyOTP(String verificationId, String smsCode, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      //UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      /*RestaurantModel(
          restaurantId: userCredential.user!.uid,
          ownerName: ownerName,
          restaurantName: restaurantName,
          busnissHours: '',
          subscription: SubscriptionModel(),
          contactInfo: ContactInfo());*/
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
