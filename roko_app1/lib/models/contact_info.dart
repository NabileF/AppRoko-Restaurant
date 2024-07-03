// ignore_for_file: public_member_api_docs, sort_constructors_first

class ContactInfo {
  int? phoneNumber;
  String? email;
  String? address;

  ContactInfo({
    this.phoneNumber,
    this.email,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
    };
  }

  factory ContactInfo.fromMap(Map<String, dynamic> map) {
    return ContactInfo(
      phoneNumber: map['phoneNumber'] as int?,
      email: map['email'] as String?,
      address: map['address'] as String?,
    );
  }
}