// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/permission.dart';

class Role {
  String roleName;
  List<Permission> permissionList;
  Role({
    required this.roleName,
    required this.permissionList,
  });
}
