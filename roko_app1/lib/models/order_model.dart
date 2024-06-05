// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/order_product_model.dart';

enum OrderStatus { confirmed, dispatched, delivred, rejected }

class OrderModel {
  String orderId;
  String branchId;
  List<OrderProductModel> products;
  DateTime orderDate;
  DateTime expectedDeliveryDate;
  String deliveryAddress;
  double totalPrice;
  OrderStatus orderStatus;
  OrderModel({
    required this.orderId,
    required this.branchId,
    required this.products,
    required this.orderDate,
    required this.expectedDeliveryDate,
    required this.deliveryAddress,
    required this.totalPrice,
    required this.orderStatus,
  });
}
