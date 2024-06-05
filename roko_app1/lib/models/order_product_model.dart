// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/product_model.dart';

class OrderProductModel {
  ProductModel product;
  int quantity;
  double price;
  OrderProductModel({
    required this.product,
    required this.quantity,
    required this.price,
  });
  
}
