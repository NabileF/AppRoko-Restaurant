import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roko_app1/services/auth_methods.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<GetSignIn>((event, emit) async {
      emit(SigninLoading());
      try {
        bool userExists =
            await AuthMethods().checkIfPhoneNumberExists(event.phoneNumber);
        if (userExists) {
          final result = await AuthMethods()
              .verifyPhoneNumber(phoneNumber: event.phoneNumber);
          final state1 = result['state']!;
          final verificationId = result['verificationId']!;
          if (state1 == 'Send OTP') {
            emit(SigninOTPSend(verificationId, event.phoneNumber));
          } else if (state1 == 'Verified') {
            emit(SigninVerified());
          } else {
            emit(SigninError('Unknown state: $state1'));
          }
        } else {
          emit(SigninUserNotExist());
        }
      } catch (e) {
        emit(SigninError(e.toString()));
      }
    });
    on<GetOTPVerification>((event, emit) async {
      emit(SigninLoading());

      try {
        final result = await AuthMethods()
            .verifyOTP(event.verificationId, event.verificationCode);
        final state1 = result['state']!;
        if (state1 == 'Verified') {
          emit(SigninVerified());
        } else {
          emit(SigninError('Unknown state: $state1'));
        }
      } catch (e) {
        emit(SigninError(e.toString()));
      }
    });
  }
}
