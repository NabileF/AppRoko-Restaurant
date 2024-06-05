// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names

import 'package:roko_app1/models/contact_info.dart';
import 'package:roko_app1/models/rating_model.dart';

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
}
