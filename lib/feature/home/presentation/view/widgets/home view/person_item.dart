import 'package:flutter/material.dart';
import 'package:virtual_closet/core/models/user_model.dart';

class PersonItem extends StatelessWidget {
  final UserModel user;
  const PersonItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(user.photoURL),
        ),
        const SizedBox(height: 5),
        Text(
          user.name,
        ),
      ],
    );
  }
}
