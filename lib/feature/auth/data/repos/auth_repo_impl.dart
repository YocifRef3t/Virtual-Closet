import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_closet/core/errors/failure.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/feature/auth/data/repos/auth_repo.dart';
import 'package:http/http.dart' as http;

import '../../../../helper/api_helper.dart';

class AuthRepoImpl implements AuthRepo {
  final String baseURL = "https://abdelnaby.store";
  @override
  Future<Either<Failure, MyUserModel>> register({
    required File image,
    required String name,
    required String email,
    required String password,
    required String phoneNum,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://abdelnaby.store/api/auth/register"),
      );
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        File(image.path).readAsBytesSync(),
        filename: image.path,
      ));
      var result = await http.Response.fromStream(await request.send());
      var data = jsonDecode(result.body);
      if (data["status"]) {
        MyUserModel user = MyUserModel(
          token: data['data']['original']['access_token'],
          id: data['data']['original']['user']['id'],
          name: data['data']['original']['user']['name'],
          email: data['data']['original']['user']['email'],
          phone: data['data']['original']['user']['phone'],
          photoURL: data['data']['original']['user']['media'][0]
              ['original_url'],
        );
        return right(user);
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (e) {
      return left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyUserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var result = await APIHelper().post(
        url: "$baseURL/api/auth/login",
        body: {
          'email': email,
          'password': password,
        },
      );
      var data = jsonDecode(result.body);
      if (data['status']) {
        MyUserModel user = MyUserModel(
          token: data['data']['original']['access_token'],
          id: data['data']['original']['user']['id'],
          name: data['data']['original']['user']['name'],
          email: data['data']['original']['user']['email'],
          phone: data['data']['original']['user']['phone'],
          photoURL: data['data']['original']['user']['media'][0]
              ['original_url'],
        );
        return right(user);
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> pickImage() async {
    try {
      final picker = ImagePicker();
      var pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        return right(File(pickedImage.path));
      } else {
        return left(
          Failure(errorMessage: "There is an error while pick image"),
        );
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }
}
