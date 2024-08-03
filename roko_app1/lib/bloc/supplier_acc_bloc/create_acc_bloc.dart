import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_acc_event.dart';
import 'create_acc_state.dart';
import '../../models/supplier_model.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(SupplierInitial());

  @override
  Stream<SupplierState> mapEventToState(SupplierEvent event) async* {
    if (event is CreateSupplier) {
      yield SupplierLoading();
      try {
        await event.supplier.createAccount(); // Assuming createAccount() is a Future<void>
        yield SupplierLoaded(message: 'Your account has been created!');
      } catch (e) {
        yield SupplierError(error: e.toString());
      }
    }
  }
}
