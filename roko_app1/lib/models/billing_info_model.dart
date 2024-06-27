

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BillingInfoModel {
  int? cardNumber;
  DateTime? expiryDate;
  int? cvv;
  BillingInfoModel({
     this.cardNumber,
     this.expiryDate,
     this.cvv,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'expiryDate': expiryDate!.millisecondsSinceEpoch,
      'cvv': cvv,
    };
  }

  factory BillingInfoModel.fromMap(Map<String, dynamic> map) {
    return BillingInfoModel(
      cardNumber: map['cardNumber'] as int,
      expiryDate: DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int),
      cvv: map['cvv'] as int,
    );
  }


  
}
