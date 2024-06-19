import 'package:flutter/material.dart';
import 'package:virtual_closet/core/models/user_model.dart';
import 'person_item.dart';

class PersonsListView extends StatelessWidget {
  final List<UserModel> users;
  const PersonsListView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PersonItem(
            user: users[index],
          ),
        ),
      ),
    );
  }
}
