import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'widgets/make outfit view/make_outfit_view_body.dart';
import 'package:virtual_closet/feature/outfit/presentation/manage/outfit%20cubit/outfit_cubit.dart';

class MakeOutFitView extends StatelessWidget {
  final MyUserModel user;
  const MakeOutFitView({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffde6fa3),
        child: const Icon(Icons.done_all),
        onPressed: () {
          BlocProvider.of<OutfitCubit>(context).uploadImages(token: user.token);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Make your outfit",
          style: TextStyle(
            color: Color(0xffde6fa3),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xffde6fa3),
          ),
        ),
      ),
      body: MakeOutFitViewBody(
        user: user,
      ),
    );
  }
}
