// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roko_app1/models/contact_info.dart';

class RestaurantModel {
  String restaurantId;
  String ownerName;
  String restaurantName;
  ContactInfo contactInfo;
  String busnissHours;
  //SubscriptionModel subscription;
  RestaurantModel({
    required this.restaurantId,
    required this.ownerName,
    required this.restaurantName,
    required this.contactInfo,
    required this.busnissHours,
    // required this.subscription,
  });

  Map<String, dynamic> toJson() => {
        'restaurantId': restaurantId,
        'ownerName': ownerName,
        'restaurantName': restaurantName,
        'contactInfo': contactInfo.toJson(),
        'busnissHours': busnissHours,
        //  'subscription': subscription.toJson(),
      };

  factory RestaurantModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return RestaurantModel(
      restaurantId: snapshot['restaurantId'] as String,
      ownerName: snapshot['ownerName'] as String,
      restaurantName: snapshot['restaurantName'] as String,
      busnissHours: snapshot['busnissHours'] as String,
      /*subscription: SubscriptionModel.fromMap(
          map['subscription'] as Map<String, dynamic>),*/
      contactInfo: ContactInfo.fromMap(snapshot['contactInfo']),
    );
  }
}
