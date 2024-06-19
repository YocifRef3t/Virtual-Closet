import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/feature/home/presentation/manage/home%20cubit/home_cubit.dart';
import 'package:virtual_closet/feature/home/presentation/manage/profile%20cubit/profile_cubit.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/profile%20view/profile_view_body.dart';


class ProfileView extends StatelessWidget {
  final MyUserModel user;
  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            BlocProvider.of<HomeCubit>(context).navigate(1);
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
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: ProfileViewBody(
          user: user,
        ),
      ),
    );
  }
}
