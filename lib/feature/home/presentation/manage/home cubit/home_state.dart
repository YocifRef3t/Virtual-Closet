part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchOutfitsLoading extends HomeState {}

final class Navigate extends HomeState {
  final int index;

  Navigate({required this.index});
}

final class FetchOutfitsSuccess extends HomeState {
  final List<OutfitModel> outfits;
  FetchOutfitsSuccess({required this.outfits});
}

final class FetchOutfitsFailure extends HomeState {
  final String errorMessage;
  FetchOutfitsFailure({required this.errorMessage});
}

final class FetchAllUsersLoading extends HomeState {}

final class FetchAllUsersSuccess extends HomeState {
  final List<UserModel> users;
  FetchAllUsersSuccess({required this.users});
}

final class FetchAllUsersFailure extends HomeState {
  final String errorMessage;

  FetchAllUsersFailure({required this.errorMessage});
}

final class AddToFavLoading extends HomeState {}

final class AddToFavSuccess extends HomeState {}

final class AddToFavFailure extends HomeState {
  final String errorMessage;

  AddToFavFailure({required this.errorMessage});
}

final class SearchLoading extends HomeState {}

final class SearchSuccess extends HomeState {
  final Map<String, dynamic> data;
  SearchSuccess({required this.data});
}

final class SearchFailure extends HomeState {
  final String errorMessage;
  SearchFailure({required this.errorMessage});
}
