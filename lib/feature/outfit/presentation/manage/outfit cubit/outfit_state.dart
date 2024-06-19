part of 'outfit_cubit.dart';

@immutable
sealed class OutfitState {}

final class OutfitInitial extends OutfitState {}

final class GetOutfitLoading extends OutfitState {}

final class ChangeFlag extends OutfitState {
  final int flag;
  ChangeFlag({required this.flag});
}

final class GetOutfitSuccess extends OutfitState {
  final List<File> files;
  GetOutfitSuccess({required this.files});
}

final class GetOutfitFailure extends OutfitState {
  final String errorMessage;
  GetOutfitFailure({required this.errorMessage});
}

final class OutfitChange extends OutfitState {
  final ClotheModel clothes;
  OutfitChange({required this.clothes});
}

final class UploadImagesLoading extends OutfitState {}

final class UploadImagesSuccess extends OutfitState {
  final String message;

  UploadImagesSuccess({required this.message});
}

final class UploadImagesFailure extends OutfitState {
  final String errorMessage;
  UploadImagesFailure({required this.errorMessage});
}
