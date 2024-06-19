import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';

import '../../../../../../core/models/outfit_model.dart';
import '../../../../../../core/utls/custom_snack_bar.dart';
import '../../../manage/profile cubit/profile_cubit.dart';
import '../home view/recommended_list_view.dart';

class FavoriteListView extends StatefulWidget {
  final MyUserModel user;
  const FavoriteListView({super.key, required this.user});

  @override
  State<FavoriteListView> createState() => _MyOutfitsListViewState();
}

class _MyOutfitsListViewState extends State<FavoriteListView> {
  bool isLoading = false;
  List<OutfitModel> outfits = [];

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).fetchFavorite(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is FetchFavoriteLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is FetchFavoriteSuccess) {
          isLoading = false;
          outfits = state.outfits;
          setState(() {});
        } else if (state is FetchFavoriteFailure) {
          ShowCustomSnackBar(context).failure(message: state.errorMessage);
        }
      },
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: !isLoading
            ? RecommendedListView(
                user: widget.user,
                outfits: outfits,
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xfff186bd),
                ),
              ),
      ),
    );
  }
}
