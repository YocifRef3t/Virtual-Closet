import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_closet/feature/outfit/data/repos/make%20outfit%20repo/make_outfit_repo.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/errors/failure.dart';

class MakeOutfitRepoImpl implements MakeOutfitRepo {
  @override
  Future<Either<Failure, List<File>>> getImages() async {
    try {
      List<File> files = [];
      final ImagePicker picker = ImagePicker();
      var response = await picker.pickMultiImage();
      final List<XFile> data = response;
      if (data.isNotEmpty) {
        for (int i = 0; i < data.length; i++) {
          files.add(File(data[i].path));
        }
        if (files.isNotEmpty) {
          return right(files);
        } else {
          return left(Failure(errorMessage: "Can not pick images"));
        }
      } else {
        return left(Failure(errorMessage: "Can not pick images"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImages({
    required String token,
    required String name,
    required List<File> images,
    String? description,
    required int flag,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://abdelnaby.store/api/store"),
      );
      request.headers['Authorization'] = "Bearer $token";
      request.fields['name'] = name;
      request.fields['description'] = description!;
      request.fields['flag'] = flag.toString();
      for (int i = 0; i < images.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image[$i]',
            File(images[i].path).readAsBytesSync(),
            filename: images[i].path,
          ),
        );
      }
      var result = await request.send();
      if (result.statusCode == 200) {
        return right("Images uploaded successfully");
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }
}
