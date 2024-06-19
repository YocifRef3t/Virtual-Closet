import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/feature/auth/presentation/view/widgets/register%20view/register_view_body.dart';

import '../manage/cubits/register cubit/register_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterViewBody(),
        ),
      ),
    );
  }
}
