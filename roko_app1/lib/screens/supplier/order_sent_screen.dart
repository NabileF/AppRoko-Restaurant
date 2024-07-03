import 'package:flutter/material.dart';
import 'package:roko_app1/models/supplier_model.dart';
import '../../app_colors/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderSentScreen extends StatelessWidget {
  Map<String, dynamic>? data;
  SupplierModel? supplier;

  OrderSentScreen({this.data, this.supplier});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        child: Container(
          width: double.infinity,
          child: Stack(children: [
            const Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/order_sent.png"),
              width: double.infinity,
            ),
            const Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/img.png"),
            ),
            Text(
              appLocalizations.orderConfirmationKeyWithArgs(
                  "${supplier!.representativeName!}"),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Positioned(
              bottom: 100,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.order,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations.requestSentKey,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(data!["request_date"])
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations.productsFoundKey,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(data!["products_count"])
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppColors.lightBlue,
        onPressed: () {
          // ChatSample order = ChatSample(isSender:true,message: Container(
          //   padding:const EdgeInsets.all(10),
          //   decoration:const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.all(Radius.circular(20))
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children:
          //     [
          //       Text(
          //         appLocalizations.order,
          //         style:const TextStyle(
          //             fontSize: 20
          //         ),
          //
          //       ),
          //       const Divider(),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children:
          //           [
          //             Text(
          //               appLocalizations.requestSentKey,
          //               style: const TextStyle(
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             Text(
          //                 data!["request_date"],
          //                 style: TextStyle(
          //                   fontSize: 12
          //                 ),
          //             )
          //           ],
          //         ),
          //       ),
          //       const Divider(),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children:
          //           [
          //              Text(
          //               appLocalizations.productsFoundKey,
          //               style:const TextStyle(
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             Text(
          //                 data!["products_count"]
          //             ),
          //           ],
          //         ),
          //       ),
          //       const Divider(),
          //       GestureDetector(
          //         onTap: (){
          //
          //         },
          //         child:const Padding(
          //           padding:  EdgeInsets.all(8.0),
          //           child: Text(
          //               "Details",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 color: Colors.blue,
          //               )
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),);
          // OrderScreen.chat.add(order);
          // AppFunctions.navigateTo(context, OrderScreen(chatSample: order,supplier: supplier,));
        },
        child: const CircleAvatar(
          backgroundColor: AppColors.lightBlue,
          child: Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
