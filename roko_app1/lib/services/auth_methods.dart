import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roko_app1/models/contact_info.dart';
import 'package:roko_app1/models/restaurant_model.dart';
import 'package:roko_app1/screens/home_page.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
// This function verifies the user's phone number to send them an SMS code.
  verifyPhoneNumber({required String phoneNumber}) async {
    // creates a Completer object that will be used to complete a future values.
    final Completer<Map<String, String>> completer = Completer();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      // This handler will only be called on Android devices which support automatic SMS code resolution. 
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _auth.signInWithCredential(credential);
          // If the user signs in successfully, set the state to 'Verified'
          completer.complete({'state': 'Verified'});
        } on Exception catch (e) {
          print(e.toString());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        completer.completeError(e.code);
      },
      // When Firebase sends an SMS code to the device, this handler is triggered with a verificationId and resendToken
      codeSent: (String verificationId, int? resendToken) async {
        // When code is sent to the user, set the state to 'Send OTP' and store the verificationId for OTP verification
        completer
            .complete({'state': 'Send OTP', 'verificationId': verificationId});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.completeError('Timeout');
      },
    );
    return completer.future; 
  }
  // This function verifies the SMS code sent to the user to sign them in afterwards.
  verifyOTP(String verificationId, String smsCode) async {
    final Completer<Map<String, String>> completer = Completer();
    try {
       // Create a PhoneAuthCredential with the SMS code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      // If the user signs in successfully, set the state to 'Verified'
      completer.complete({'state': 'Verified'});
    } on Exception catch (e) {
      print(e.toString());
      completer.completeError(e.toString());
    }
    return completer.future;
  }
  // this function stores the restaurant info in the Firestore database
  addRestaurantInfo(
      {required String restaurantName,
      required String ownerName,
      required String city,
      required String email,
      required BuildContext context}) {
    try {
      // Create the restaurant model with user's input data
      RestaurantModel restaurant = RestaurantModel(
          restaurantId: _auth.currentUser!.uid,
          ownerName: ownerName,
          restaurantName: restaurantName,
          busnissHours: '',
          contactInfo: ContactInfo(
            address: city,
            phoneNumber: _auth.currentUser!.phoneNumber!,
            email: email,
          ));
      // Stores the restaurant info into Firestore using the restaurant ID as the document ID
      restaurants.doc(_auth.currentUser!.uid).set(restaurant.toJson());
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    } on Exception catch (e) {
      print(e.toString());
    }
  }
  // This function checks if the user's phone number exists in the database
  checkIfPhoneNumberExists(String phoneNumber) async {
    final querySnapshot = await restaurants
        .where('contactInfo.phoneNumber', isEqualTo: phoneNumber)
        .get();
    bool exists = querySnapshot.docs.isNotEmpty;

    return exists;
  }
}
