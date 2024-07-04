// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactInfo {
  String phoneNumber;
  String email;
  String address;
  ContactInfo({
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
    };
  }

  factory ContactInfo.fromMap(Map<String, dynamic> map) {
    return ContactInfo(
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
    );
  }
}
