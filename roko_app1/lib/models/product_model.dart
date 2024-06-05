// ignore_for_file: public_member_api_docs, sort_constructors_first

enum Unit {
  kilogram,
  gram,
  liter,
  milliliter,
  piece,
  dozen,
  pack,
}

enum Category {
  fruits,
  vegetables,
  dairy,
  meat,
  seafood,
  grains,
  beverages,
  bakery,
  frozen,
  cannedGoods,
  condiments,
}

class ProductModel {
  String productId;
  String supplierId;
  String productName;
  String productDescription;
  String productImage;
  Category category;
  Unit unit;
  String brand;
  DateTime expiredDate;
  double price;
  int stockLevel;
  bool isAvailable;
  ProductModel({
    required this.productId,
    required this.supplierId,
    required this.productName,
    required this.productDescription,
    required this.productImage,
    required this.category,
    required this.unit,
    required this.brand,
    required this.expiredDate,
    required this.price,
    required this.stockLevel,
    required this.isAvailable,
  });
}
