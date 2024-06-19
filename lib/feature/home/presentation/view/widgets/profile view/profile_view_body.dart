import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/feature/home/presentation/manage/profile%20cubit/profile_cubit.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/profile%20view/favorite_outfit_list_view.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/profile%20view/my_outfit_list_view.dart';
import 'custom_profile_tapbar.dart';

class ProfileViewBody extends StatefulWidget {
  final MyUserModel user;
  const ProfileViewBody({super.key, required this.user});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  PageController controller = PageController();
  List<OutfitModel> outfits = [];
  bool isLoading = false;

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).fetchUserOutfit(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ChangeView) {
          controller.jumpToPage(state.index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.user.photoURL),
            ),
            const SizedBox(height: 10),
            Text(
              widget.user.name,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomProfileTapbar(),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MyOutfitsListView(user: widget.user),
                  FavoriteListView(user: widget.user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
