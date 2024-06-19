import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:virtual_closet/core/models/clothe_model.dart';
import 'package:virtual_closet/feature/outfit/data/repos/make%20outfit%20repo/make_outfit_repo_impl.dart';
part 'outfit_state.dart';

class OutfitCubit extends Cubit<OutfitState> {
  OutfitCubit() : super(OutfitInitial());
  String? name, description;
  int flag = 1;
  List<File> images = [];

  void changeOutfit(ClotheModel clothes) =>
      emit(OutfitChange(clothes: clothes));

  Future<void> getImages() async {
    emit(GetOutfitLoading());
    var result = await MakeOutfitRepoImpl().getImages();
    result.fold(
      (failure) => emit(GetOutfitFailure(errorMessage: failure.errorMessage)),
      (files) {
        images = files;
        emit(GetOutfitSuccess(files: files));
      },
    );
  }

  Future<void> uploadImages({required String token}) async {
    if (name == null) {
      emit(UploadImagesFailure(errorMessage: "Name is required"));
      return;
    }
    if (description == null) {
      emit(UploadImagesFailure(errorMessage: "Description is required"));
      return;
    }
    if (images.isEmpty) {
      emit(UploadImagesFailure(
        errorMessage: "You should select 1 image at least",
      ));
      return;
    }
    emit(UploadImagesLoading());
    var result = await MakeOutfitRepoImpl().uploadImages(
      token: token,
      name: name!,
      description: description!,
      images: images,
      flag: flag,
    );
    result.fold(
      (failure) =>
          emit(UploadImagesFailure(errorMessage: failure.errorMessage)),
      (message) => emit(UploadImagesSuccess(message: message)),
    );
  }

  void changeFlag(int flag1) {
    if (flag1 == 0) {
      flag = 1;
    } else {
      flag = 0;
    }
    emit(ChangeFlag(flag: flag));
  }
}
