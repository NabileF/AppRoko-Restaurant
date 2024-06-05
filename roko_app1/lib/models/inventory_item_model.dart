// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/product_model.dart';

class InventoryItemModel {
  ProductModel product;
  int quantity;
  int threshold;
  DateTime expiryDate;
  InventoryItemModel({
    required this.product,
    required this.quantity,
    required this.threshold,
    required this.expiryDate,
  });
}
