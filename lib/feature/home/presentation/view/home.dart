import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/feature/home/presentation/manage/home%20cubit/home_cubit.dart';
import 'package:virtual_closet/feature/home/presentation/view/home_view.dart';
import 'package:virtual_closet/feature/home/presentation/view/notification_view.dart';
import 'package:virtual_closet/feature/home/presentation/view/profile_view.dart';

import '../../../../core/models/my_user_model.dart';

class Home extends StatefulWidget {
  final MyUserModel user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController(initialPage: 1);
  int index = 1;

  void navigateTo() {
    controller.animateToPage(
      index,
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is Navigate) {
          index = state.index;
          navigateTo();
          setState(() {});
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  index = value;
                  setState(() {});
                },
                controller: controller,
                children: [
                  ProfileView(user: widget.user),
                  HomeView(user: widget.user),
                  NotificationView(user: widget.user),
                ],
              ),
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      index = 0;
                      setState(() {});
                      navigateTo();
                    },
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? const Color(0xffde6fa3)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/user_icon.png",
                          height: 24,
                          color: index == 0
                              ? Colors.white
                              : const Color(0xffde6fa3),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      index = 1;
                      setState(() {});
                      navigateTo();
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: index == 1
                            ? const Color(0xffde6fa3)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/home_icon.png",
                          height: 24,
                          color: index == 1
                              ? Colors.white
                              : const Color(0xffde6fa3),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      index = 2;
                      setState(() {});
                      navigateTo();
                    },
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: index == 2
                            ? const Color(0xffde6fa3)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/alarm_icon.png",
                          height: 24,
                          color: index == 2
                              ? Colors.white
                              : const Color(0xffde6fa3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
