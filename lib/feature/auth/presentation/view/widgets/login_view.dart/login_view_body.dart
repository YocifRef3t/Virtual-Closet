import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/utls/app_router.dart';
import 'package:virtual_closet/core/utls/custom_snack_bar.dart';
import 'package:virtual_closet/feature/auth/presentation/manage/cubits/login%20cubit/login_cubit.dart';

import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String? email, password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is LoginSuccess) {
          isLoading = false;
          setState(() {});
          GoRouter.of(context)
              .pushReplacement(AppRouter.kHomeViewPath, extra: state.user);
        } else if (state is LoginFailure) {
          isLoading = false;
          setState(() {});
          ShowCustomSnackBar(context).failure(message: state.errorMessage);
        } else {
          isLoading = false;
          setState(() {});
          ShowCustomSnackBar(context).failure(message: "Something went wrong");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xffbe4885),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Already have Account? ",
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kRegisterViewPath,
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xffdb836d),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  "assets/images/logo.jpg",
                  height: 65,
                ),
              ],
            ),
            const SizedBox(height: 50),
            CustomTextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (value != "") {
                    email = value;
                  } else {
                    email = null;
                  }
                } else {
                  email = null;
                }
              },
              labelText: "Email",
              hintText: "Enter your email",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (value != "") {
                    password = value;
                  } else {
                    password = null;
                  }
                } else {
                  password = null;
                }
              },
              passwordTextField: true,
              labelText: "Password",
              hintText: "Enter your password",
            ),
            const Spacer(),
            CustomButton(
              isLoading: isLoading,
              text: "Login",
              onPressed: () {
                if (email == null || password == null) {
                  ShowCustomSnackBar(context).warning(
                    message: "All fields are required",
                  );
                  return;
                }
                BlocProvider.of<LoginCubit>(context).login(
                  email: email!,
                  password: password!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
