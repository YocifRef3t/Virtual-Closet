import 'package:flutter/material.dart';
import 'package:virtual_closet/feature/splash/presentation/view/widgets/splash%20view/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SplashViewBody(),
    );
  }
}
