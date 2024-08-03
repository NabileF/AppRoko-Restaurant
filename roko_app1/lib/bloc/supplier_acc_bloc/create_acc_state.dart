import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object> get props => [];
}

class SupplierInitial extends SupplierState {}

class SupplierLoading extends SupplierState {}

class SupplierLoaded extends SupplierState {
  final String message;

  const SupplierLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class SupplierError extends SupplierState {
  final String error;

  const SupplierError({required this.error});

  @override
  List<Object> get props => [error];
}
