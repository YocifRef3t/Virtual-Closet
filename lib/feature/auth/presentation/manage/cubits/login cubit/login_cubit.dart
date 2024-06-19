import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/feature/auth/data/repos/auth_repo_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    var result = await AuthRepoImpl().login(email: email, password: password);
    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.errorMessage)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }
}
