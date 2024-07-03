import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roko_app1/models/supplier_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../app_colors/app_colors.dart';

class SupplierFinalizeOrderScreen extends StatefulWidget {
  Map<String, dynamic>? productsData;
  final SupplierModel? supplierData;

  SupplierFinalizeOrderScreen(
      {super.key, this.productsData, this.supplierData});

  @override
  State<SupplierFinalizeOrderScreen> createState() =>
      _SupplierFinalizeOrderScreenState();
}

class _SupplierFinalizeOrderScreenState
    extends State<SupplierFinalizeOrderScreen> {
  DateTime currentDate = DateTime.now();
  String date = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (date.isNotEmpty) {
      date =  appLocalizations.requestDeliveryDateKey;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // AppFunctions.navigateFrom(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
        title: Text(
          appLocalizations.orderGuideKey,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.finalizeOrderDetailsKey,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          var picker = showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.utc(2050));
                          if (picker != null) {
                            setState(() {
                              picker.then((value) {
                                if (value != null) {
                                  setState(() {
                                    currentDate = value;
                                    date = "";
                                  });
                                  print(date);
                                }
                              });
                            });
                          }
                        },
                        child: Container(
                          color: AppColors.lightBlue,
                          child: ListTile(
                            leading: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            title: Text(
                              date.isNotEmpty
                                  ? date
                                  : DateFormat.yMMMMEEEEd(Intl.systemLocale)
                                      .format(currentDate),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        appLocalizations.deliveryDateRequirement,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        appLocalizations.leaveCommentKey,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: appLocalizations.exampleComment
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: AppColors.lightBlue,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            appLocalizations.saveForYourTeamKey,
                            style: const TextStyle(
                              color: AppColors.lightBlue,
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        appLocalizations.productsKey,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        title: Text(
                          appLocalizations.productsKey,
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        trailing: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: appLocalizations.editKey,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          widget.productsData!["selected_products"].length,
                      itemBuilder: (context, index) {
                        var data =
                            widget.productsData!["selected_products"][index];
                        print(widget.productsData);
                        return ListTile(
                          leading: Text(
                            '${data["quantity"]}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            appLocalizations
                                .caseLabelWithArgs("${data["name"]}"),
                          ),
                          trailing: Text(
                            "${data["price"] * data["quantity"]}",
                            style: const TextStyle(fontSize: 19),
                          ),
                        );
                      }),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ElevatedButton(
                    onPressed: () {
                      // AppFunctions.navigateTo(
                      //     context,
                      //     OrderSentScreen(
                      //       data: {
                      //         "request_date":
                      //             DateFormat.yMMMMEEEEd(Intl.systemLocale)
                      //                 .format(currentDate),
                      //         "products_count":
                      //             widget.productsData!.length.toString()
                      //       },
                      //       supplier: widget.supplierData,
                      //     ));
                      // widget.productsData = null;
                    },
                    child: Text(appLocalizations.orderEstimationKeyWithArgs(
                        "${widget.productsData!["total_price"]}"))),
              )
            ],
          )),
    );
  }
}
