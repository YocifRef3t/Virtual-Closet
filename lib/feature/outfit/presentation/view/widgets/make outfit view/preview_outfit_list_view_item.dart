import 'package:flutter/material.dart';
import 'package:virtual_closet/core/models/clothe_model.dart';

class PreviewOutFitListViewItem extends StatelessWidget {
  final bool selected;
  final ClotheModel clothes;
  const PreviewOutFitListViewItem(
      {super.key, required this.clothes, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: selected
                ? Border.all(
                    width: 2,
                    color: const Color(0xffde6fa3),
                  )
                : null,
          ),
          child: Image.network(clothes.url),
        ),
      ),
    );
  }
}
