// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/contact_info.dart';
import 'package:roko_app1/models/role.dart';

class UserModel {
  String userId;
  String branchId;
  String userName;
  ContactInfo contactInfo;
  Role role;
  UserModel({
    required this.userId,
    required this.branchId,
    required this.userName,
    required this.contactInfo,
    required this.role,
  });
}
