import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:roko_app1/models/supplier_model.dart';
import '../../widgets/supplier_widgets/supplier_search_result.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupplierSearchByCategory extends StatefulWidget {
  final List<SupplierModel>? suppliers;
  final String? selectedCategory;

  const SupplierSearchByCategory(
      {super.key, this.suppliers, this.selectedCategory});

  @override
  State<SupplierSearchByCategory> createState() =>
      _SupplierSearchByCategoryState();
}

class _SupplierSearchByCategoryState extends State<SupplierSearchByCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.selectedCategory}"),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ConditionalBuilder(
          condition: widget.suppliers!.isNotEmpty,
          builder: (context) {
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: widget.suppliers!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        // RestaurantHomeScreen.addedSupplier.add(widget.suppliers![index]);
                        // AppFunctions.navigateFrom(context);
                      },
                      child: SupplierSearchItemResult(
                        supplierList: widget.suppliers,
                        index: index,
                      ));
                });
          },
          fallback: (context) => Center(
            child: Text(
              AppLocalizations.of(context)!.noSupplierFoundOnThisCategoryKey,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
