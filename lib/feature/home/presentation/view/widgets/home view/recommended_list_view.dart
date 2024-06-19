import 'package:flutter/material.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';

import 'recommended_item.dart';

class RecommendedListView extends StatefulWidget {
  final MyUserModel user;
  final List<OutfitModel> outfits;
  const RecommendedListView(
      {super.key, required this.outfits, required this.user});

  @override
  State<RecommendedListView> createState() => _RecommendedListViewState();
}

class _RecommendedListViewState extends State<RecommendedListView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        childAspectRatio: 1,
        crossAxisSpacing: 40,
        mainAxisSpacing: 20,
      ),
      itemCount: widget.outfits.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10),
        child: RecommendedItem(
          user: widget.user,
          outfit: widget.outfits[index],
        ),
      ),
    );
  }
}
