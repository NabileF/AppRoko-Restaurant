// ignore_for_file: must_be_immutable

part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

final class SigninInitial extends SigninState {}

final class SigninLoading extends SigninState {}

final class SigninVerified extends SigninState {}

final class SigninOTPSend extends SigninState {
  String? verificationId;
  String? phoneNumber;
  SigninOTPSend(this.verificationId, this.phoneNumber);
}

final class SigninError extends SigninState {
  String? error;
  SigninError(this.error);
}

final class SigninUserNotExist extends SigninState {}
