// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class GetSignUp extends SignupEvent {
  String phoneNumber;
  GetSignUp({
    required this.phoneNumber,
  });
}

class GetOTPVerification extends SignupEvent {
  String verificationId;
  String verificationCode;
  GetOTPVerification({
    required this.verificationId,
    required this.verificationCode,
  });
}
