import 'package:flutter/material.dart';
import 'package:roko_app1/models/product_model.dart';
import 'package:roko_app1/models/supplier_model.dart';
import '../../app_colors/app_colors.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class SupplierOrderScreen extends StatefulWidget {
  final List<ProductModel>? selectedProduct;
  final SupplierModel? supplierData;

  const SupplierOrderScreen(
      {super.key, this.selectedProduct, this.supplierData});

  @override
  State<SupplierOrderScreen> createState() => _SupplierOrderScreenState();
}

class _SupplierOrderScreenState extends State<SupplierOrderScreen> {
  //List of Categories (Buttons)
  List<Category> listOfCategories = [
    Category.fruits,
    Category.condiments,
    Category.fruits,
    Category.frozen,
    Category.dairy,
    Category.meat
  ];

  // List<double> qtes = [];
  List<int> qtes = [];
  List<double> price_qte_cal = [];
  List<Map<String, dynamic>> selectedProductWithQuantity =
      []; //This list after the user select his products with their quantity
  // String? selectedCategory;
  Category? selectedCategory;
  double sum = 0.0;
  List<bool>? isSelected;
  bool minus = false;
  String totalPrice = "";
  AppLocalizations? appLocalizations;

  @override
  void initState() {
    super.initState();
    // qtes = List<double>.generate(widget.selectedProduct!.length, (index) => widget.selectedProduct![index].quantity);
    // price_qte_cal = List<double>.generate(widget.selectedProduct!.length, (index) => widget.selectedProduct![index].price! * widget.selectedProduct![index].quantity);
    qtes = List<int>.generate(widget.selectedProduct!.length,
        (index) => widget.selectedProduct![index].stockLevel);
    price_qte_cal = List<double>.generate(
        widget.selectedProduct!.length,
        (index) =>
            widget.selectedProduct![index].price! *
            widget.selectedProduct![index].stockLevel);
    isSelected = List<bool>.filled(listOfCategories.length, false);
    print(widget.selectedProduct);
    selectedCategory = listOfCategories[
        0]; // Initialize selectedCategory with a Category value this is a new line
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    // selectedCategory = listOfCategories[0].label;
    selectedCategory = listOfCategories[0] as Category?;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              // AppFunctions.navigateFrom(context);
            },
          ),
          centerTitle: true,
          title: Text(
            appLocalizations!.orderGuideKey,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, color: Colors.blue)),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 60, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            List.generate(listOfCategories.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: isSelected![index]
                                      ? Colors.white
                                      : Colors.blue,
                                  backgroundColor: isSelected![index]
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isSelected![index] = !isSelected![index];
                                  });
                                },
                                child: Text("${listOfCategories[index].name}")),
                          );
                        })),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations!.minimumOrderValueKeyWithArgs("100"),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.darkDeepBlue,
                          ),
                        ),
                        Text(
                          appLocalizations!.minimumOrderValueExplanation,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "$selectedCategory".split('.').last,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 17),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: widget.selectedProduct!.length,
                      itemBuilder: (context, index) {
                        ProductModel e = widget.selectedProduct![index];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.productName,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    e.price.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                e.productDescription,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "DH ${e.price}/${e.unit}",
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        e.stockLevel.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.red,
                                      ),
                                      Text(
                                        e.stockLevel.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    // e.quantity > 0
                                    e.stockLevel > 0
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // if(e.quantity > 0){
                                                //   --e.quantity;
                                                //   qtes[index] = e.quantity;
                                                //   price_qte_cal[index] = e.price! * e.quantity;
                                                if (e.stockLevel > 0) {
                                                  --e.stockLevel;
                                                  qtes[index] = e.stockLevel;
                                                  price_qte_cal[index] =
                                                      e.price! * e.stockLevel;
                                                  //selectedProductWithQuantity.add(e.toJson());
                                                }
                                                if (qtes.every((element) =>
                                                    element == 0)) {
                                                  sum = 0;
                                                }
                                              });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.white,
                                                ),
                                                width: 40,
                                                height: 40,
                                                child: const Icon(
                                                  Icons.minimize,
                                                  color: Colors.blue,
                                                )),
                                          )
                                        : Container(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // e.quantity +=1;
                                          // qtes[index] = e.quantity;
                                          // var cal = e.price! * e.quantity;
                                          e.stockLevel += 1;
                                          qtes[index] = e.stockLevel;
                                          var cal = e.price! * e.stockLevel;
                                          price_qte_cal[index] = cal;
                                          if (qtes.every(
                                              (element) => element == 0)) {
                                            sum = 0;
                                          }
                                        });
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue,
                                          ),
                                          width: 40,
                                          height: 40,
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            //if(qtes.any((element) => element != 0))
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        onPressed: () {
                          // AppFunctions.navigateFrom(context);
                        },
                        child: Text(
                          appLocalizations!.browseCatalogKey,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      )),
                      const SizedBox(
                        width: 6,
                      ),
                      qtes.any((element) => element != 0)
                          ? Expanded(
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                onPressed: () {
                                  // List<Map<String, dynamic>> jsonDataList = [];
                                  // Map<String,dynamic> data = {};
                                  // for(SupplierProduct i in widget.selectedProduct!){
                                  //   if(i.quantity > 0.0){
                                  //     jsonDataList.add(i.toJson());
                                  //   }
                                  // }
                                  // data["selected_products"] = jsonDataList;
                                  // // reduce function will sum the prices for us
                                  // String totalPrice = price_qte_cal.reduce((value, element) => value + element).toStringAsFixed(2);
                                  // data["total_price"] = totalPrice;
                                  // AppFunctions.navigateTo(context, SupplierFinalizeOrderScreen(productsData: data,supplierData: widget.supplierData,));
                                },
                                child: Text(
                                  appLocalizations!.viewOrderEstKeyWithArgs(
                                      price_qte_cal
                                          .reduce((value, element) =>
                                              value + element)
                                          .toStringAsFixed(2)),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                              height: 1,
                            ))
                    ],
                  )),
            )
          ],
        ));
  }
}
