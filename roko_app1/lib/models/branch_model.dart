// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/contact_info.dart';


class BranchModel {
  String branchId;
  String restaurantId;
  String name;
  ContactInfo contactInfo;
  String businessHours;
  List<String> suppliers;
  BranchModel({
    required this.branchId,
    required this.restaurantId,
    required this.name,
    required this.contactInfo,
    required this.businessHours,
    required this.suppliers,
  });
}
