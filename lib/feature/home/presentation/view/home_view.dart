import 'package:flutter/material.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/home%20view/home_view_body.dart';

class HomeView extends StatelessWidget {
  final MyUserModel user;
  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: HomeViewBody(
          user: user,
        ),
      ),
    );
  }
}
