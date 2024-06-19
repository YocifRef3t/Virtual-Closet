import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/models/user_model.dart';
import 'package:virtual_closet/core/utls/custom_snack_bar.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/home%20view/your_clothes_category.dart';
import '../../../../../../core/widgets/custom_appbar.dart';
import '../../../manage/home cubit/home_cubit.dart';
import 'custom_search_bar.dart';
import 'person_list_view.dart';
import 'recommended_category.dart';
import 'recommended_list_view.dart';

class HomeViewBody extends StatefulWidget {
  final MyUserModel user;
  const HomeViewBody({super.key, required this.user});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<UserModel> users = [];
  bool isLoading = false;
  List<OutfitModel> outfits = [];
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).fetchAllOutfits(widget.user);
    BlocProvider.of<HomeCubit>(context).fetchAllUsers(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is FetchOutfitsLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is FetchOutfitsSuccess) {
          isLoading = false;
          outfits = state.outfits;
          setState(() {});
        } else if (state is FetchAllUsersFailure) {
          ShowCustomSnackBar(context).failure(message: state.errorMessage);
        } else if (state is FetchAllUsersSuccess) {
          users = state.users;
          setState(() {});
        }
      },
      child: !isLoading
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAppbar(user: widget.user),
                              CustomSearchBar(
                                user: widget.user,
                              ),
                              const SizedBox(height: 20),
                              users.isNotEmpty
                                  ? const Text(
                                      "People You May Know Them Outfits",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        users.isNotEmpty
                            ? PersonsListView(users: users)
                            : const SizedBox(),
                        outfits.isNotEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(20),
                                child: RecommendedCategory(),
                              )
                            : const SizedBox(),
                        outfits.isNotEmpty
                            ? SizedBox(
                                height: 250,
                                width: MediaQuery.of(context).size.width - 10,
                                child: RecommendedListView(
                                  user: widget.user,
                                  outfits: outfits,
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: YourClothesCategory(
                            user: widget.user,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xfff186bd),
              ),
            ),
    );
  }
}
