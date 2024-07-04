// ignore_for_file: must_be_immutable

part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class GetSignIn extends SigninEvent {
  String phoneNumber;
  GetSignIn({
    required this.phoneNumber,
  });
}

class GetOTPVerification extends SigninEvent {
  String verificationId;
  String verificationCode;
  GetOTPVerification({
    required this.verificationId,
    required this.verificationCode,
  });
}
