import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/feature/auth/presentation/manage/cubits/login%20cubit/login_cubit.dart';
import 'package:virtual_closet/feature/auth/presentation/view/widgets/login_view.dart/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginViewBody(),
        ),
      ),
    );
  }
}
