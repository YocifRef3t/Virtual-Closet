part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class PickImageSuccess extends RegisterState {
  final File image;
  PickImageSuccess({required this.image});
}

final class PickImageFailure extends RegisterState {
  final String errorMessage;
  PickImageFailure({required this.errorMessage});
}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final MyUserModel user;
  RegisterSuccess({required this.user});
}

final class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure({required this.errorMessage});
}
