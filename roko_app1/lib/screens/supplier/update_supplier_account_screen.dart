import 'dart:typed_data';  // Import for handling binary data
import 'package:flutter/cupertino.dart';  // Import for Cupertino widgets
import 'package:flutter/material.dart';  // Import for Material Design widgets
import 'package:flutter_spinkit/flutter_spinkit.dart';  // Import for loading spinner
import 'package:cloud_firestore/cloud_firestore.dart';  // Import for Firestore database
import 'package:firebase_storage/firebase_storage.dart';  // Import for Firebase Storage
import 'package:flutter/services.dart';  // Import for platform services
import 'package:roko_app1/app_colors/app_colors.dart';  // Import for app colors
import 'package:roko_app1/models/supplier_model.dart';  // Import for supplier model
import 'package:roko_app1/models/contact_info.dart';  // Import for contact info model
import 'package:image_picker/image_picker.dart';  // Import for image picker

class UpdateSupplierAccountScreen extends StatefulWidget {
  final String supplierId;  // Supplier ID passed from previous screen

  const UpdateSupplierAccountScreen({super.key, required this.supplierId});

  @override
  State<UpdateSupplierAccountScreen> createState() =>
      _UpdateSupplierAccountScreenState();
}

class _UpdateSupplierAccountScreenState extends State<UpdateSupplierAccountScreen> {
  final _formKey = GlobalKey<FormState>();  // Key for the form
  final _supplierNameController = TextEditingController();
  final _representativeNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  Uint8List? _image;  // Variable to hold the image data
  bool _isLoading = true;  // Loading state
  String? _errorMessage;  // Error message state
  SupplierModel? _supplierModel;  // Supplier model instance
  String? _currentProfilePictureUrl;  // Current profile picture URL

  @override
  void initState() {
    super.initState();
    _fetchSupplierData();  // Fetch supplier data when the widget is initialized
  }

  // Fetch supplier data from Firestore
  Future<void> _fetchSupplierData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(widget.supplierId)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        _supplierModel = SupplierModel.fromMap(data);
        _supplierNameController.text = data['supplierName'] ?? '';
        _representativeNameController.text = data['representativeName'] ?? '';
        _phoneNumberController.text = data['contactInfo']['phoneNumber'] ?? '';
        _emailController.text = data['contactInfo']['email'] ?? '';
        _addressController.text = data['contactInfo']['address'] ?? '';
        _currentProfilePictureUrl = data['profilePicture'] ?? '';

        if (_currentProfilePictureUrl!.isNotEmpty) {
          _image = await _fetchImage(_currentProfilePictureUrl!);
        }

        setState(() {
          _isLoading = false;  // Data fetching complete
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Supplier data not found';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching supplier data: $e';
      });
    }
  }

  // Fetch image data from Firebase Storage
  Future<Uint8List> _fetchImage(String imageUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      final data = await ref.getData();
      return data!;
    } catch (e) {
      throw Exception('Error fetching image: $e');
    }
  }

  // Update supplier profile
  Future<void> _updateSupplierProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;  // Start loading
      });

      try {
        // Update the local supplier model
        _supplierModel!.supplierName = _supplierNameController.text;
        _supplierModel!.representativeName = _representativeNameController.text;
        _supplierModel!.contactInfo = ContactInfo(
          phoneNumber: _phoneNumberController.text,
          email: _emailController.text,
          address: _addressController.text,
        );
        _supplierModel!.updatedAt = DateTime.now();

        // Only upload the updated profile picture if it has changed
        if (_image != null) {
          // Delete the previous profile picture if it exists
          if (_currentProfilePictureUrl != null && _currentProfilePictureUrl!.isNotEmpty) {
            await _deletePreviousImage(_currentProfilePictureUrl!);
          }

          // Upload the new profile picture
          String downloadUrl = await _uploadImage();
          _supplierModel!.profilePicture = downloadUrl;
        }

        // Call the update method of SupplierModel
        await _supplierModel!.updateProfile();

        setState(() {
          _isLoading = false;  // End loading
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Supplier profile updated successfully')),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error updating supplier profile: $e';
        });
      }
    }
  }

  // Delete the previous image from Firebase Storage
  Future<void> _deletePreviousImage(String imageUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Error deleting previous image: $e');
    }
  }

  // Upload new image to Firebase Storage and get the download URL
  Future<String> _uploadImage() async {
    final ref = FirebaseStorage.instance.ref().child('profile_pictures').child(widget.supplierId);
    await ref.putData(_image!);
    return await ref.getDownloadURL();
  }

  @override
  void dispose() {
    _supplierNameController.dispose();
    _representativeNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Account"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.lightBlue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? Center(
        child: SpinKitCircle(
          color: AppColors.lightBlue,
        ),
      )
          : _errorMessage != null
          ? Center(
        child: Text(_errorMessage!),
      )
          : Padding(
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
                      onPressed: _updateSupplierProfile,
                      child: const Text(
                        "Update",
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

  // Show options to pick image from camera or gallery
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
              await _pickImage(ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Gallery',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await _pickImage(ImageSource.gallery);
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

  // Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = bytes;  // Set the selected image
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error picking image: $e';  // Set error message if image picking fails
      });
    }
  }
}
