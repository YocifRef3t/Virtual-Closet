import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/feature/home/presentation/manage/profile%20cubit/profile_cubit.dart';

class CustomProfileTapbar extends StatefulWidget {
  const CustomProfileTapbar({super.key});

  @override
  State<CustomProfileTapbar> createState() => _CustomProfileTapbarState();
}

class _CustomProfileTapbarState extends State<CustomProfileTapbar> {
  Widget item({required String text, required bool selected}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 4,
            color: selected ? const Color(0xffde6fa3) : Colors.transparent,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? const Color(0xffde6fa3) : Colors.grey,
        ),
      ),
    );
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ChangeView) {
          selectedIndex = state.index;
          setState(() {});
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                BlocProvider.of<ProfileCubit>(context).changeView(0);
              },
              child: item(
                text: "Your Outfit",
                selected: selectedIndex == 0,
              ),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<ProfileCubit>(context).changeView(1);
              },
              child: item(
                text: "Favorite Outfit",
                selected: selectedIndex == 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
