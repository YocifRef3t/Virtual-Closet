import 'package:flutter/material.dart';

class CustomTapbar extends StatelessWidget {
  const CustomTapbar({super.key});

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
        style: const TextStyle(
          color: Color(0xffde6fa3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          item(
            text: "Outfit name",
            selected: true,
          ),
        ],
      ),
    );
  }
}
