import 'package:flutter/material.dart';

class RecommendedCategory extends StatelessWidget {
  const RecommendedCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              "Recommended for this weather",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              "23 C",
              style: TextStyle(
                color: Color(0xffde6fa3),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
