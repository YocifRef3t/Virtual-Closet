import 'package:flutter/material.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';

class CustomAppbar extends StatelessWidget {
  final MyUserModel user;
  const CustomAppbar({super.key, required this.user});

  String getName() {
    if (user.name.contains(" ")) {
      return user.name.split(" ")[0];
    } else {
      return user.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Hi,${user.name}!",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 25,
              color: Color(0xffde6fa3),
            ),
          ),
        ),
        const Spacer(),
        Image.asset(
          "assets/images/logo.jpg",
          height: 50,
        ),
      ],
    );
  }
}
