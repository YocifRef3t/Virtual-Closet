import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/utls/custom_snack_bar.dart';
import 'package:virtual_closet/feature/home/presentation/manage/home%20cubit/home_cubit.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/preview%20outfit%20view/preview_outfit_view_body.dart';

class PreviewOutfitView extends StatefulWidget {
  final MyUserModel user;
  final OutfitModel outfit;
  const PreviewOutfitView(
      {super.key, required this.outfit, required this.user});

  @override
  State<PreviewOutfitView> createState() => _PreviewOutfitViewState();
}

class _PreviewOutfitViewState extends State<PreviewOutfitView> {
  late bool isFav;
  bool isLoading = false;
  @override
  void initState() {
    isFav = widget.outfit.favorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddToFavLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is AddToFavSuccess) {
          isLoading = false;
          isFav = !isFav;
          setState(() {});
          BlocProvider.of<HomeCubit>(context).fetchAllOutfits(widget.user);
        } else if (state is AddToFavFailure) {
          isLoading = false;
          setState(() {});
          ShowCustomSnackBar(context).failure(message: state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: isFav ? Colors.white : const Color(0xffef5da8),
          onPressed: () {
            BlocProvider.of<HomeCubit>(context).addToFavorite(
              user: widget.user,
              id: widget.outfit.id.toString(),
            );
          },
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: isFav ? const Color(0xffde6fa3) : Colors.white,
                  ),
                )
              : Icon(
                  Icons.favorite,
                  color: isFav ? Colors.red : Colors.white,
                ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xffde6fa3),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.share,
                color: Color(0xffde6fa3),
              ),
            )
          ],
        ),
        body: PreviewOutfitViewBody(
          outfit: widget.outfit,
        ),
      ),
    );
  }
}
