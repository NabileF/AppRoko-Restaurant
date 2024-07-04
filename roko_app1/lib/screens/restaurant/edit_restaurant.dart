// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:roko_app1/models/restaurant_model.dart';
import 'package:roko_app1/screens/restaurant/restaurant_profile.dart';
import 'package:roko_app1/services/restaurant_methods.dart';

class EditRestaurant extends StatefulWidget {
  const EditRestaurant({super.key});

  @override
  State<EditRestaurant> createState() => _EditRestaurantState();
}

class _EditRestaurantState extends State<EditRestaurant> {
  TextEditingController restaurantNameCon = TextEditingController();
  TextEditingController ownerNameCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneNumberCon = TextEditingController();
  TextEditingController businessHoursCon = TextEditingController();
  RestaurantModel? restaurantData;
  restaurantInfo() async {
    restaurantData = await RestaurantMethods().getRestaurantInfo();
    restaurantNameCon.text = restaurantData!.restaurantName;
    ownerNameCon.text = restaurantData!.ownerName;
    addressCon.text = restaurantData!.contactInfo.address;
    emailCon.text = restaurantData!.contactInfo.email;
    phoneNumberCon.text = restaurantData!.contactInfo.phoneNumber;
    businessHoursCon.text = restaurantData!.busnissHours;
  }

  @override
  void initState() {
    super.initState();
    restaurantInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    restaurantNameCon.text = value;
                  });
                },
                controller: restaurantNameCon,
                decoration: InputDecoration(hintText: 'Restaurant Name'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    ownerNameCon.text = value;
                  });
                },
                controller: ownerNameCon,
                decoration: InputDecoration(hintText: 'Restaurant Owner Name'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    addressCon.text = value;
                  });
                },
                controller: addressCon,
                decoration: InputDecoration(hintText: 'Restaurant Address'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    emailCon.text = value;
                  });
                },
                controller: emailCon,
                decoration: InputDecoration(hintText: 'Restaurant Email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    phoneNumberCon.text = value;
                  });
                },
                controller: phoneNumberCon,
                decoration:
                    InputDecoration(hintText: 'Restaurant Phone Number'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    businessHoursCon.text = value;
                  });
                },
                controller: businessHoursCon,
                decoration:
                    InputDecoration(hintText: 'Restaurant Business Hours'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await RestaurantMethods().editRestaurantInfo(
                        restaurantName: restaurantNameCon.text,
                        ownerName: ownerNameCon.text,
                        businessHour: businessHoursCon.text,
                        address: addressCon.text,
                        email: emailCon.text,
                        phoneNumber: phoneNumberCon.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantProfile(),
                        ));
                  },
                  child: Text('Update'))
            ],
          ),
        ),
      ),
    );
  }
}
