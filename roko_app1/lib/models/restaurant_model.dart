// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:roko_app1/models/contact_info.dart';
import 'package:roko_app1/models/subscription_model.dart';

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

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      restaurantId: map['restaurantId'] as String,
      ownerName: map['ownerName'] as String,
      restaurantName: map['restaurantName'] as String,
      busnissHours: map['busnissHours'] as String,
      /*subscription: SubscriptionModel.fromMap(
          map['subscription'] as Map<String, dynamic>),*/
      contactInfo: ContactInfo.fromMap(map['contactInfo']),
    );
  }
}
