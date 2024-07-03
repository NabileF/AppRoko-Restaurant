import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roko_app1/app_colors/app_colors.dart';
import 'package:roko_app1/models/supplier_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupplierProfileScreen extends StatelessWidget {
  final SupplierModel? supplier;
  const SupplierProfileScreen({super.key, this.supplier});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    // List of Delivery Days !! I didn't want to Hard code it
    List<String> list = [
      // Add actual localized delivery day strings here
      appLocalizations.moKey,appLocalizations.tueKey,appLocalizations.wedKey,appLocalizations.thurKey,appLocalizations.friKey
    ];

    if (supplier == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const Center(
          child: Text("Supplier information is not available."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Implement navigation function
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/supplier_pics/wefruts.jpg"),
                  ),
                  Positioned(
                    left: 0,
                    right: 230,
                    bottom: 20,
                    child: CircleAvatar(
                      radius: 40.0,
                      child: Image.asset("assets/supplier_pics/we_fruts_profile.png"),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                supplier!.representativeName,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                appLocalizations.immensePrideKey(supplier!.representativeName!),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall!.copyWith(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: appLocalizations.showMoreKey,style: textTheme.labelLarge!.copyWith(
                        color: Colors.blue
                    )
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                appLocalizations.aboutKey,
                style: textTheme.labelLarge!.copyWith(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0.02),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.42,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF475269).withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        leading: const FaIcon(
                          FontAwesomeIcons.calendarCheck,
                          color: AppColors.blue,
                        ),
                        title: Text(
                          appLocalizations.deliveryDaysKey,
                          style: textTheme.labelLarge,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (String i in list)
                              Text(
                                i.padLeft(i.length + 1, " "),
                              ),
                          ],
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const FaIcon(
                          FontAwesomeIcons.solidClock,
                          color: AppColors.blue,
                        ),
                        title: Text(
                          appLocalizations.cutOffTimesKey,
                          style: textTheme.labelLarge!.copyWith(),
                        ),
                        subtitle: const Text("4:00pm"),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const FaIcon(
                          FontAwesomeIcons.boxesPacking,
                          color: AppColors.blue,
                        ),
                        title: Text(
                          appLocalizations.minimumOrderValueKey,
                          style: textTheme.labelLarge,
                        ),
                        subtitle: const Text("120"),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.backpack,
                          color: AppColors.blue,
                        ),
                        title: Text(
                          appLocalizations.deliveryFeeKey,
                          style: textTheme.labelLarge,
                        ),
                        subtitle: const Text("10"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Add Confirmation
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Container(
                          color: Colors.white70,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            children: [
                              Text(
                                appLocalizations.onlyExistingCustomersKey,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.darkDeepBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                appLocalizations.existingCustomerIndicateKey(supplier!.representativeName!),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: AppColors.lightBlue,
                                    foregroundColor: Colors.white
                                  ),
                                  child: Text(
                                    appLocalizations.existingCustomerKey
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.blue,
                                    ),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.blue.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    appLocalizations.notExistingCustomerKey,
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  appLocalizations.addSupplierKey,
                  style: textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
