// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/billing_info_model.dart';

class SubscriptionModel {
  String? planId;
  BillingInfoModel? billingInfo;
  String? status;
  DateTime? subscriptionDate;
  
  SubscriptionModel({
    this.planId,
    this.billingInfo,
    this.status,
    this.subscriptionDate
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planId': planId,
      'billingInfo': billingInfo!.toMap(),
      'status': status,
      'subscriptionDate': subscriptionDate!.millisecondsSinceEpoch,
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      planId: map['planId'] as String,
      billingInfo: BillingInfoModel.fromMap(map['billingInfo'] as Map<String,dynamic>),
      status: map['status'] as String,
      subscriptionDate: DateTime.fromMillisecondsSinceEpoch(map['subscriptionDate'] as int),
    );
  }

  

 

  
}
