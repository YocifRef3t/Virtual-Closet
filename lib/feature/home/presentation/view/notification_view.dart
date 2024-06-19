import 'package:flutter/material.dart';

import '../../../../core/models/my_user_model.dart';

class NotificationView extends StatelessWidget {
  final MyUserModel user;
  const NotificationView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "There is no notifications yet",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
