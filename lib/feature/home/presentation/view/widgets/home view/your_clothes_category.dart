import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/utls/app_router.dart';
import 'package:virtual_closet/feature/home/presentation/manage/home%20cubit/home_cubit.dart';

class YourClothesCategory extends StatelessWidget {
  final MyUserModel user;
  const YourClothesCategory({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Clothes",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                BlocProvider.of<HomeCubit>(context).navigate(0);
              },
              child: Container(
                width: 150,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/clothes.jpeg"),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: const Text(
                    "Closet Clothes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  AppRouter.kMakeOutfitViewPath,
                  extra: user,
                );
              },
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(
                    color: const Color(0xffde6fa3),
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Color(0xffde6fa3),
                      ),
                      Text(
                        "Add new clothes",
                        style: TextStyle(
                          color: Color(0xffde6fa3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
