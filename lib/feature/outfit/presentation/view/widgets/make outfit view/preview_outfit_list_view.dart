import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/clothe_model.dart';
import 'package:virtual_closet/feature/outfit/presentation/manage/outfit%20cubit/outfit_cubit.dart';

import 'preview_outfit_list_view_item.dart';

class PreviewOutfitListView extends StatefulWidget {
  final List<ClotheModel> clothes;
  const PreviewOutfitListView({super.key, required this.clothes});

  @override
  State<PreviewOutfitListView> createState() => _PreviewOutfitListViewState();
}

class _PreviewOutfitListViewState extends State<PreviewOutfitListView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<OutfitCubit, OutfitState>(
      listener: (context, state) {},
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.clothes.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              selectedIndex = index;
              setState(() {});
              BlocProvider.of<OutfitCubit>(context)
                  .changeOutfit(widget.clothes[selectedIndex]);
            },
            child: PreviewOutFitListViewItem(
              selected: index == selectedIndex,
              clothes: widget.clothes[index],
            ),
          ),
        ),
      ),
    );
  }
}
