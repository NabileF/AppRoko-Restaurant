import 'package:flutter/material.dart';

import '../../app_colors/app_colors.dart';
import '../../models/contact_info.dart';
import '../../models/supplier_model.dart';

class UpdateSupplierAccountScreen extends StatefulWidget {
  final SupplierModel supplier;

  const UpdateSupplierAccountScreen({super.key, required this.supplier});

  @override
  State<UpdateSupplierAccountScreen> createState() => _UpdateSupplierAccountScreenState();
}

class _UpdateSupplierAccountScreenState extends State<UpdateSupplierAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _repNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _profilePictureController;
  late DateTime _unexpectedDeliveryDay;
  late bool _isExisting;
  late CommunicationPreference _communicationPreference;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier.supplierName);
    _repNameController = TextEditingController(text: widget.supplier.representativeName);
    _phoneNumberController = TextEditingController(text: widget.supplier.contactInfo.phoneNumber?.toString());
    _emailController = TextEditingController(text: widget.supplier.contactInfo.email);
    _addressController = TextEditingController(text: widget.supplier.contactInfo.address);
    _profilePictureController = TextEditingController(text: widget.supplier.profilePicture);
    _unexpectedDeliveryDay = widget.supplier.unexpectedDeliveryDay;
    _isExisting = widget.supplier.isExisting;
    _communicationPreference = widget.supplier.communicationPreference;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _repNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _profilePictureController.dispose();
    super.dispose();
  }

  Future<void> _updateSupplier() async {
    if (_formKey.currentState!.validate()) {
      // Create a new ContactInfo object
      final contactInfo = ContactInfo(
        phoneNumber: int.tryParse(_phoneNumberController.text),
        email: _emailController.text,
        address: _addressController.text,
      );

      final updatedSupplier = SupplierModel(
        supplierId: widget.supplier.supplierId,
        supplierName: _nameController.text,
        representativeName: _repNameController.text,
        contactInfo: contactInfo,
        profilePicture: _profilePictureController.text,
        unexpectedDeliveryDay: _unexpectedDeliveryDay,
        isExisting: _isExisting,
        communicationPreference: _communicationPreference,
        rating: widget.supplier.rating,
        createdAt: widget.supplier.createdAt,
        updatedAt: DateTime.now(),
      );

      await updatedSupplier.updateProfile();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.lightBlue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
