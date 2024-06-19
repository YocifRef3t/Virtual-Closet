import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/utls/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).pushReplacement(AppRouter.kLoginViewPath);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.jpg",
        ),
      ],
    );
  }
}
