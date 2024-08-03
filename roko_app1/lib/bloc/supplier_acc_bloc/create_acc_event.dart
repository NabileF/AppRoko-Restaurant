import 'package:equatable/equatable.dart';
import '../../models/supplier_model.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();

  @override
  List<Object> get props => [];
}

class CreateSupplier extends SupplierEvent {
  final SupplierModel supplier;

  const CreateSupplier({required this.supplier});

  @override
  List<Object> get props => [supplier];
}
