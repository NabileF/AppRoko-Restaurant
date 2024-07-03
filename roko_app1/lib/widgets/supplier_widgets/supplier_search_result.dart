import 'package:flutter/material.dart';
import 'package:roko_app1/models/supplier_model.dart';
// import 'package:rokoapp/screens/suppliers/supplier_profile_screen.dart';
// import 'package:rokoapp/shared_widgets/components/useable_functions.dart';

// import '../../models/supplier.dart';
// import '../../screens/restaurant/restaurant_home_screen.dart';

class SupplierSearchItemResult extends StatelessWidget{
  final List<SupplierModel>? supplierList;
  final int? index;
  const SupplierSearchItemResult({super.key, this.supplierList,this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 6,
              spreadRadius: -8,
            ),
          ]
      ),
      child: GestureDetector(
        onTap: () {
        // AppFunctions.navigateTo(context, SupplierProfileScreen(supplier: supplierList![index!],));
        },
        child: Card(
          shadowColor: Colors.black,
          child: Stack(
            children:
            [
              Image(
                fit: BoxFit.cover,
                image: AssetImage(
                    // supplierList![index!].profilePicture!
                  "assets/supplier_pics/wefruts.jpg"
                ),
              ),
              Positioned(
                  left: 0,
                  top: 120,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage(
                                supplierList![index!].profilePicture!
                            ),
                          ),
                          Text(
                            supplierList![index!].representativeName!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}
