import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:virtual_closet/core/errors/failure.dart';

abstract class MakeOutfitRepo {
  Future<Either<Failure, List<File>>> getImages();
  /******************************************** */
  Future<Either<Failure, String>> uploadImages({
    required String token,
    required String name,
    required List<File> images,
    String? description,
    required int flag,
  });
}
