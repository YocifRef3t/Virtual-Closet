import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/utls/app_router.dart';
import 'package:virtual_closet/core/utls/custom_snack_bar.dart';
import 'package:virtual_closet/core/widgets/custom_button.dart';
import 'package:virtual_closet/core/widgets/custom_text_field.dart';

import '../../../manage/cubits/register cubit/register_cubit.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  String? name, email, password, conPassword, phoneNum;
  File? image;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is RegisterSuccess) {
          isLoading = false;
          setState(() {});
          GoRouter.of(context)
              .pushReplacement(AppRouter.kHomeViewPath, extra: state.user);
        } else if (state is RegisterFailure) {
          isLoading = false;
          setState(() {});
          ShowCustomSnackBar(context).failure(message: state.errorMessage);
        } else if (state is PickImageSuccess) {
          image = state.image;
          setState(() {});
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
                            GoRouter.of(context).pop();
                          },
                          child: const Text(
                            "Login",
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
            IntrinsicHeight(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    image != null
                        ? GestureDetector(
                            onTap: () {
                              BlocProvider.of<RegisterCubit>(context)
                                  .pickImage();
                            },
                            child: CircleAvatar(
                                radius: 40, backgroundImage: FileImage(image!)),
                          )
                        : GestureDetector(
                            onTap: () {
                              BlocProvider.of<RegisterCubit>(context)
                                  .pickImage();
                            },
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                "assets/images/woman.png",
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (value != "") {
                            name = value;
                          } else {
                            name = null;
                          }
                        } else {
                          name = null;
                        }
                      },
                      labelText: "Name",
                      hintText: "Enter your full name",
                    ),
                    const SizedBox(height: 16),
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
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          ShowCustomSnackBar(context).warning(
                            message:
                                "Only available for Saudi Arabia  right now",
                          );
                        },
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/Saudi_Arabia_icon.png",
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 5),
                                const Text("+966"),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                            Expanded(
                              child: CustomTextField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (value != "") {
                                      phoneNum = value;
                                    } else {
                                      phoneNum = null;
                                    }
                                  } else {
                                    phoneNum = null;
                                  }
                                },
                                hintText: "Phone",
                                border: const Border(),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      labelText: "Password",
                      hintText: "Enter your password",
                      passwordTextField: true,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (value != "") {
                            conPassword = value;
                          } else {
                            conPassword = null;
                          }
                        } else {
                          conPassword = null;
                        }
                      },
                      labelText: "Confirm Password",
                      hintText: "Enter your confirm password",
                      passwordTextField: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              isLoading: isLoading,
              text: "Sign Up",
              onPressed: () {
                if (name == null ||
                    email == null ||
                    password == null ||
                    phoneNum == null) {
                  ShowCustomSnackBar(context).warning(
                    message: "All fields are required",
                  );
                  return;
                }
                if (password != conPassword) {
                  ShowCustomSnackBar(context).warning(
                    message: "password not match",
                  );
                  return;
                }
                BlocProvider.of<RegisterCubit>(context).register(
                  name: name!,
                  email: email!,
                  password: password!,
                  phoneNum: phoneNum!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
