import 'dart:async'; // For asynchronous programming
import 'dart:io'; // For handling file input/output

import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore database
import 'package:firebase_storage/firebase_storage.dart'; // For Firebase storage
import 'package:flutter/cupertino.dart'; // For Cupertino widgets
import 'package:flutter/material.dart'; // For Material Design widgets
import 'package:flutter/services.dart'; // For handling text input and other services
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For loading spinners
import 'package:image_picker/image_picker.dart'; // For picking images from gallery/camera
import 'package:roko_app1/app_colors/app_colors.dart'; // Custom app colors

import '../../models/contact_info.dart'; // Custom model for contact information
import '../../models/supplier_model.dart'; // Custom model for supplier information

// StatefulWidget for creating supplier account
class CreateSupplierAccountScreen extends StatefulWidget {
  const CreateSupplierAccountScreen({super.key});

  @override
  State<CreateSupplierAccountScreen> createState() =>
      _CreateSupplierAccountScreenState();
}

// State class for CreateSupplierAccountScreen
class _CreateSupplierAccountScreenState extends State<CreateSupplierAccountScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _supplierNameController = TextEditingController(); // Controller for supplier name input
  final _representativeNameController = TextEditingController(); // Controller for representative name input
  final _phoneNumberController = TextEditingController(); // Controller for phone number input
  final _emailController = TextEditingController(); // Controller for email input
  final _addressController = TextEditingController(); // Controller for address input

  Uint8List? _image; // For storing selected image
  File? selectedImage; // For storing selected image file

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _supplierNameController.dispose();
    _representativeNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Function to add supplier to Firestore
  Future<void> _addSupplier() async {
    if (_formKey.currentState?.validate() ?? false) {
      _showLoadingDialog();

      String? imageUrl;
      if (selectedImage != null) {
        imageUrl = await _uploadImageToStorage();
      }

      // Creating a new supplier model
      final supplier = SupplierModel(
        supplierId: FirebaseFirestore.instance.collection('suppliers').doc().id,
        supplierName: _supplierNameController.text,
        representativeName: _representativeNameController.text,
        contactInfo: ContactInfo(
          phoneNumber: _phoneNumberController.text,
          email: _emailController.text,
          address: _addressController.text,
        ),
        profilePicture: imageUrl ?? "",
        unexpectedDeliveryDay: DateTime.now(),
        isExisting: true,
        communicationPreference: CommunicationPreference.Email,
        rating: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Saving the supplier to Firestore
      await supplier.createAccount();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your account has been created!')));
    }
  }

  // Function to upload image to Firebase storage
  Future<String> _uploadImageToStorage() async {
    final storageRef = FirebaseStorage.instance.ref().child('profile_pictures').child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(selectedImage!);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.lightBlue),
          onPressed: () {
            // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: [
                  Stack(children: [
                    _image != null
                        ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                        : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          "https://t4.ftcdn.net/jpg/03/31/69/91/360_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg"),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: const Icon(Icons.add_a_photo),
                        iconSize: 30,
                      ),
                    )
                  ]),
                  const Divider(
                    color: AppColors.lightBlue,
                    height: 40,
                    thickness: 0.2,
                  ),
                  _buildTextFormField(
                      _supplierNameController, 'Full Name', TextInputType.text,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  _buildTextFormField(_representativeNameController,
                      'Representative Name', TextInputType.text, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your representative name';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  _buildTextFormField(_phoneNumberController, 'Phone Number',
                      TextInputType.phone, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                      _emailController, 'Email', TextInputType.emailAddress,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                      _addressController, 'Address', TextInputType.text,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      }),
                  const Divider(
                    color: AppColors.lightBlue,
                    height: 40,
                    thickness: 0.2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _addSupplier,
                      child: const Text(
                        "Complete Account Setup",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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

  // Helper method to build text form fields
  Widget _buildTextFormField(TextEditingController controller, String labelText,
      TextInputType keyboardType, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.lightBlue,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  // Method to show image picker options (camera/gallery)
  void showImagePickerOption(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(
          'Select From',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        actions: [
          CupertinoActionSheetAction(
            child: const Text(
              'Camera',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await _pickImageFromCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Gallery',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await _pickImageFromGallery();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  // Method to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  // Method to pick image from camera
  Future<void> _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  // Method to show loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
            height: 70,
            width: 70,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitCircle(
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
