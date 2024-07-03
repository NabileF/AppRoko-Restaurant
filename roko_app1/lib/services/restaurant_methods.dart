import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roko_app1/models/restaurant_model.dart';

class RestaurantMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  getRestaurantInfo() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await restaurants.doc(currentUser.uid).get();
    return RestaurantModel.fromSnap(documentSnapshot);
  }

  editRestaurantInfo({
    required String restaurantName,
    required String ownerName,
    required String businessHour,
    String address = '',
    String email = '',
    String phoneNumber = '',
  }) async {
    User currentUser = _auth.currentUser!;
    try {
      if (restaurantName.isNotEmpty && ownerName.isNotEmpty) {
        await restaurants.doc(currentUser.uid).update({
          'restaurantName': restaurantName,
          'ownerName': ownerName,
          'busnissHours': businessHour,
          'contactInfo': {
            'address': address,
            'email': email,
            'phoneNumber': phoneNumber
          }
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
