import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/utils/city_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:roko_app1/services/auth_methods.dart';
//import 'package:rokoapp/firabase_services/firebase_service_restaurant.dart';
//import 'package:rokoapp/models/restaurant.dart';
//import 'package:rokoapp/provider/auth_provider.dart';

import 'package:roko_app1/shared_widgets/components/useable_functions.dart';

class FinalStepScreen extends StatefulWidget {
  @override
  State<FinalStepScreen> createState() => _FinalStepScreenState();
}

class _FinalStepScreenState extends State<FinalStepScreen> {
  TextEditingController restaurantName = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController restaurantEmail = TextEditingController();
  List<City>? cities;
  AppLocalizations? appLocalizations;
  String? city;

  @override
  void initState() {
    super.initState();
    getCountryCities("MA").then((value) {
      setState(() {
        cities = value;
      });
      print(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    ownerName.dispose();
    restaurantName.dispose();
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 70,
                      child: Icon(
                        Icons.camera,
                        size: 30,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildTextForm(
                      appLocalizations: appLocalizations,
                      controller: restaurantName,
                      hintText: appLocalizations.formRestaurantName,
                      errorText: appLocalizations.formRestaurantNameError),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButton<String>(
                      hint: Text(appLocalizations.selectCity),
                      value: city,
                      items: cities?.map((e) {
                        return DropdownMenuItem<String>(
                            value: e.name, child: Text(e.name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          city = value!;
                        });
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildTextForm(
                      appLocalizations: appLocalizations,
                      controller: restaurantEmail,
                      hintText: appLocalizations.formRestaurantEmail,
                      errorText: appLocalizations.formRestaurantEmailError),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildTextForm(
                      appLocalizations: appLocalizations,
                      controller: ownerName,
                      hintText: appLocalizations.formOwnerName,
                      errorText: appLocalizations.formOwnerNameError),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (city!.isNotEmpty) {
                            AuthMethods().addRestaurantInfo(
                                restaurantName: restaurantName.text,
                                ownerName: ownerName.text,
                                city: city!,
                                email: restaurantEmail.text,
                                context: context);
                          } else {
                            AppFunctions.showSnackBar(
                              context,
                              appLocalizations.selectCityError,
                              Colors.red,
                            );
                          }
                        }
                      },
                      child: Text(
                        appLocalizations.formSubmit,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextForm(
      {required AppLocalizations appLocalizations,
      required controller,
      required String hintText,
      required String errorText}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hintText,
      ),
    );
  }
}
