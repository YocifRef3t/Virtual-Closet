import 'dart:io';

import 'package:flutter/material.dart';

class MakeOutfitListViewItem extends StatelessWidget {
  final File image;
  const MakeOutfitListViewItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Image.file(image),
        ),
      ),
    );
  }
}
