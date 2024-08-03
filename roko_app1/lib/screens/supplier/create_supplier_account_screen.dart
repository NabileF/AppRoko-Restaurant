import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roko_app1/app_colors/app_colors.dart';
import '../../bloc/supplier_acc_bloc/create_acc_bloc.dart';
import '../../bloc/supplier_acc_bloc/create_acc_state.dart';
import '../../models/contact_info.dart';
import '../../models/supplier_model.dart';

class CreateSupplierAccountScreen extends StatefulWidget {
  const CreateSupplierAccountScreen({super.key});

  @override
  State<CreateSupplierAccountScreen> createState() => _CreateSupplierAccountScreenState();
}

class _CreateSupplierAccountScreenState extends State<CreateSupplierAccountScreen> {
  // Form key to manage the state of the form
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers for managing the text fields
  final _supplierNameController = TextEditingController();
  final _representativeNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  Uint8List? _image; // Stores the image data
  File? selectedImage; // Stores the selected image file

  late SupplierBloc _supplierBloc; // BLoC for managing supplier-related state

  @override
  void initState() {
    super.initState();
    _supplierBloc = SupplierBloc(); // Initialize the SupplierBloc
  }

  @override
  void dispose() {
    _supplierBloc.close(); // Close the BLoC when the widget is disposed
    _supplierNameController.dispose();
    _representativeNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Method to upload image to Firebase Storage
  Future<String> _uploadImageToStorage() async {
    final storageRef = FirebaseStorage.instance.ref().child('profile_pictures').child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = storageRef.putFile(selectedImage!); // Upload the image file
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL(); // Get the download URL of the uploaded image
    return downloadUrl;
  }

  // Method to add a new supplier
  Future<void> _addSupplier() async {
    if (_formKey.currentState?.validate() ?? false) {
      _showLoadingDialog(); // Show loading dialog

      String? imageUrl;
      if (selectedImage != null) {
        imageUrl = await _uploadImageToStorage(); // Upload image if selected
      }

      // Creating a new supplier model
      final supplier = SupplierModel(
        supplierId: FirebaseFirestore.instance.collection('suppliers').doc().id, // Generate a new document ID
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
      Navigator.of(context).pop(); // Close the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your account has been created!'))); // Show success message
    }
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

  // Method to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync(); // Read image as bytes
    });
  }

  // Method to pick image from camera
  Future<void> _pickImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync(); // Read image as bytes
    });
  }

  // Method to show image picker options (camera or gallery)
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
              await _pickImageFromCamera(); // Pick image from camera
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Gallery',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await _pickImageFromGallery(); // Pick image from gallery
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the action sheet
          },
        ),
      ),
    );
  }

  // Helper method to build a text form field
  Widget _buildTextFormField(TextEditingController controller, String labelText, TextInputType keyboardType, String? Function(String?) validator) {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _supplierBloc,
      child: BlocListener<SupplierBloc, SupplierState>(
        listener: (context, state) {
          if (state is SupplierLoading) {
            _showLoadingDialog(); // Show loading dialog when loading state
          } else if (state is SupplierLoaded) {
            Navigator.of(context).pop(); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message))); // Show success message
          } else if (state is SupplierError) {
            Navigator.of(context).pop(); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error))); // Show error message
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Create Account"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.lightBlue),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back
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
                      GestureDetector(
                        onTap: () {
                          showImagePickerOption(context); // Show image picker options
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.lightBlue,
                          backgroundImage: _image != null ? MemoryImage(_image!) : null,
                          child: _image == null
                              ? const Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.white,
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(_supplierNameController, "Supplier Name", TextInputType.text, (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the supplier name";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildTextFormField(_representativeNameController, "Representative Name", TextInputType.text, (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the representative name";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildTextFormField(_phoneNumberController, "Phone Number", TextInputType.phone, (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the phone number";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildTextFormField(_emailController, "Email", TextInputType.emailAddress, (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the email address";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildTextFormField(_addressController, "Address", TextInputType.text, (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the address";
                        }
                        return null;
                      }),
                      const Divider(color: AppColors.lightBlue, height: 40, thickness: 0.2),
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
                          onPressed: _addSupplier, // Trigger supplier addition
                          child: const Text(
                            "Complete Account Setup",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
