import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roko_app1/services/auth_methods.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    // This event is called when the user tries to sign up by clicking on the sign up button
    on<GetSignUp>((event, emit) async {
      // First emit the SignupLoading state
      emit(SignupLoading());
      try {
        bool userExists =
            await AuthMethods().checkIfPhoneNumberExists(event.phoneNumber);
        // Calling the verifyPhoneNumber function to verify the user's phone number
        if (userExists) {
          emit(SignupUserExist());
        } else {
          final result = await AuthMethods()
              .verifyPhoneNumber(phoneNumber: event.phoneNumber);
          // Stores the state and verificationId values into variables
          final state1 = result['state']!;
          final verificationId = result['verificationId']!;
          // if state is 'Send OTP' emit the SignupOTPSend state with the verificationId.
          if (state1 == 'Send OTP') {
            emit(SignupOTPSend(verificationId));
          }
          // if state is 'Verified' emit the SignupVerified state.
          else if (state1 == 'Verified') {
            emit(SignupVerified());
          }
          // else emit the SignupError state with the error message.
          else {
            emit(SignupError('Unknown state: $state1'));
          }
        }
      } catch (e) {
        emit(SignupError(e.toString()));
      }
    });
    // This event is called when the user tries to verify the otp msg by clicking on the verification button
    on<GetOTPVerification>((event, emit) async {
      // First emit the SignupLoading state
      emit(SignupLoading());

      try {
        // Calling the verifyOTP function to verify the OTP Msg.
        final result = await AuthMethods()
            .verifyOTP(event.verificationId, event.verificationCode);
        final state1 = result['state']!;
        // if state is 'Verified' emit the SignupVerified state.
        if (state1 == 'Verified') {
          emit(SignupVerified());
        }
        // else emit the SignupError state with the error message.
        else {
          emit(SignupError('Unknown state: $state1'));
        }
      } catch (e) {
        emit(SignupError(e.toString()));
      }
    });
  }
}
