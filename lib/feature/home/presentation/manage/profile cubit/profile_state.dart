part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ChangeView extends ProfileState {
  final int index;

  ChangeView({required this.index});
}

final class FetchUOFLoading extends ProfileState {}

final class FetchUOFSuccess extends ProfileState {
  final List<OutfitModel> outfits;

  FetchUOFSuccess({required this.outfits});
}

final class FetchUOFFailure extends ProfileState {
  final String errorMessage;
  FetchUOFFailure({required this.errorMessage});
}

final class FetchFavoriteLoading extends ProfileState {}

final class FetchFavoriteSuccess extends ProfileState {
  final List<OutfitModel> outfits;
  FetchFavoriteSuccess({required this.outfits});
}

final class FetchFavoriteFailure extends ProfileState {
  final String errorMessage;
  FetchFavoriteFailure({required this.errorMessage});
}
