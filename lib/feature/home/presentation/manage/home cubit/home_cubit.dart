import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/user_model.dart';
import 'package:virtual_closet/feature/home/data/repos/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void navigate(int index) => emit(Navigate(index: index));

  Future<void> fetchAllOutfits(MyUserModel user) async {
    emit(FetchOutfitsLoading());
    var result = await HomeRepoImpl().fetchAllOutfits(user);
    result.fold(
      (failure) => emit(
        FetchOutfitsFailure(errorMessage: failure.errorMessage),
      ),
      (outfits) => emit(FetchOutfitsSuccess(outfits: outfits)),
    );
  }

  Future<void> fetchAllUsers(MyUserModel user) async {
    emit(FetchAllUsersLoading());
    var result = await HomeRepoImpl().fetchAllUsers(user);
    result.fold(
      (failure) => emit(
        FetchOutfitsFailure(errorMessage: failure.errorMessage),
      ),
      (users) => emit(FetchAllUsersSuccess(users: users)),
    );
  }

  Future<void> addToFavorite(
      {required MyUserModel user, required String id}) async {
    emit(AddToFavLoading());
    var result = await HomeRepoImpl().createFavorite(user: user, id: id);
    result.fold(
      (failure) => emit(AddToFavFailure(errorMessage: failure.errorMessage)),
      (isTrue) => emit(AddToFavSuccess()),
    );
  }

  Future<void> search(
      {required MyUserModel user, required String searchKey}) async {
    emit(SearchLoading());
    var result = await HomeRepoImpl().search(user: user, searchKey: searchKey);
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errorMessage)),
      (map) {
        if (map.isNotEmpty) {
          emit(SearchSuccess(data: map));
        } else {
          emit(SearchFailure(errorMessage: "Not Found"));
        }
      },
    );
  }
}
