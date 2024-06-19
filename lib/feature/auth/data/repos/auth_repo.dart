import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:virtual_closet/core/errors/failure.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, File>> pickImage();
  /****************************************/
  Future<Either<Failure, MyUserModel>> register({
    required File image,
    required String name,
    required String email,
    required String password,
    required String phoneNum,
  });
  /****************************************/
  Future<Either<Failure, MyUserModel>> login({
    required String email,
    required String password,
  });
}
