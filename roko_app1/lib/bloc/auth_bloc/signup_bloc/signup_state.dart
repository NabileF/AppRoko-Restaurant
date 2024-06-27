// ignore_for_file: must_be_immutable

part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupVerified extends SignupState {}

final class SignupOTPSend extends SignupState {
  String? verificationId;
  SignupOTPSend(this.verificationId);
}

final class SignupError extends SignupState {
  String? error;
  SignupError(this.error);
}

final class SignupUserExist extends SignupState {}
