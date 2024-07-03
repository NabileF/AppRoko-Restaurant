// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:roko_app1/app_colors/app_colors.dart';
import 'package:roko_app1/models/restaurant_model.dart';
import 'package:roko_app1/screens/restaurant/edit_restaurant.dart';
import 'package:roko_app1/services/restaurant_methods.dart';

class RestaurantProfile extends StatefulWidget {
  const RestaurantProfile({super.key});

  @override
  State<RestaurantProfile> createState() => _RestaurantProfileState();
}

class _RestaurantProfileState extends State<RestaurantProfile> {
  RestaurantModel? restaurantData;
  bool isLoading = true;
  restaurantInfo() async {
    restaurantData = await RestaurantMethods().getRestaurantInfo();
    setState(() {
      isLoading = false;
    });
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
        title: Text('Restaurant Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditRestaurant(),
                    ));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: AppColors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      restaurantData!.restaurantName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person,
                        size: 28,
                      ),
                      Text(
                        restaurantData!.ownerName,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 27,
                      ),
                      Text(
                        restaurantData!.contactInfo.address,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.email,
                        size: 25,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        restaurantData!.contactInfo.email,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 27,
                      ),
                      Text(
                        restaurantData!.contactInfo.phoneNumber,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 27,
                      ),
                      Text(
                        restaurantData!.busnissHours,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
