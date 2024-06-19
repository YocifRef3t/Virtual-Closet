import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/feature/auth/data/repos/auth_repo_impl.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  File? image;

  Future<void> pickImage() async {
    var result = await AuthRepoImpl().pickImage();
    result.fold(
      (failure) => emit(PickImageFailure(errorMessage: failure.errorMessage)),
      (file) {
        image = file;
        emit(PickImageSuccess(image: file));
      },
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNum,
  }) async {
    emit(RegisterLoading());
    if (image == null) {
      emit(RegisterFailure(errorMessage: "Image can not be null"));
      return;
    }
    var result = await AuthRepoImpl().register(
      image: image!,
      name: name,
      email: email,
      password: password,
      phoneNum: phoneNum,
    );
    result.fold(
      (failure) => emit(RegisterFailure(errorMessage: failure.errorMessage)),
      (user) => emit(RegisterSuccess(user: user)),
    );
  }
}
