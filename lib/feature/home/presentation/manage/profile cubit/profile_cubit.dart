import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/feature/home/data/repos/home_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void changeView(int index) => emit(ChangeView(index: index));

  Future<void> fetchUserOutfit(MyUserModel user) async {
    emit(FetchUOFLoading());
    var result = await HomeRepoImpl().fetchUserOutfits(user);
    result.fold(
      (failure) => emit(
        FetchUOFFailure(errorMessage: failure.errorMessage),
      ),
      (outfits) => emit(FetchUOFSuccess(outfits: outfits)),
    );
  }

  Future<void> fetchFavorite(MyUserModel user) async {
    emit(FetchFavoriteLoading());
    var result = await HomeRepoImpl().fetchFavorite(user);
    result.fold(
      (failure) => emit(
        FetchFavoriteFailure(errorMessage: failure.errorMessage),
      ),
      (outfits) => emit(FetchFavoriteSuccess(outfits: outfits)),
    );
  }
}
