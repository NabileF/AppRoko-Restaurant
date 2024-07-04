// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names

import 'package:roko_app1/models/contact_info.dart';
import 'package:roko_app1/models/rating_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

enum CommunicationPreference {
  SMS,
  WhatsApp,
  Email,
}

class SupplierModel {
  String supplierId;
  String supplierName;
  String representativeName;
  ContactInfo contactInfo;
  String profilePicture;
  DateTime unexpectedDeliveryDay;
  bool isExisting;
  CommunicationPreference communicationPreference;
  List<RatingModel> rating;
  DateTime createdAt;
  DateTime updatedAt;

  SupplierModel({
    required this.supplierId,
    required this.supplierName,
    required this.representativeName,
    required this.contactInfo,
    required this.profilePicture,
    required this.unexpectedDeliveryDay,
    required this.isExisting,
    required this.communicationPreference,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'supplierId': supplierId,
      'supplierName': supplierName,
      'representativeName': representativeName,
      'contactInfo': contactInfo.toJson(),
      'profilePicture': profilePicture,
      'unexpectedDeliveryDay': dateFormat.format(unexpectedDeliveryDay),
      // Format date
      'isExisting': isExisting,
      'communicationPreference': communicationPreference.name,
      'rating': rating.map((r) => r.toMap()).toList(),
      'createdAt': dateFormat.format(createdAt),
      // Format date
      'updatedAt': dateFormat.format(updatedAt),
      // Format date
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      supplierId: map['supplierId'] as String,
      supplierName: map['supplierName'] as String,
      representativeName: map['representativeName'] as String,
      contactInfo:
          ContactInfo.fromMap(map['contactInfo'] as Map<String, dynamic>),
      profilePicture: map['profilePicture'] as String,
      unexpectedDeliveryDay: DateTime.parse(map['unexpectedDeliveryDay']),
      isExisting: map['isExisting'] as bool,
      communicationPreference: CommunicationPreference.values
          .firstWhere((e) => e.toString() == map['communicationPreference']),
      rating: (map['rating'] as List<dynamic>)
          .map((r) => RatingModel.fromMap(r as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  //region Methods
  Future<void> createAccount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('suppliers').doc(supplierId).set(toMap());
  }

  Future<void> updateProfile() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('suppliers').doc(supplierId).update(toMap());
  }

  Future<void> setComPref(CommunicationPreference newPreference) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('suppliers').doc(supplierId).update({
      'communicationPreference': newPreference.toString(),
      'updatedAt': DateTime.now().toIso8601String(),
    });

    // Update the local model instance
    communicationPreference = newPreference;
    updatedAt = DateTime.now();
  }
//endregion
}
