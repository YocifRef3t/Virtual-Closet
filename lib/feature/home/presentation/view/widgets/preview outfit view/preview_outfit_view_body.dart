import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/feature/outfit/presentation/manage/outfit%20cubit/outfit_cubit.dart';
import 'package:virtual_closet/feature/outfit/presentation/view/widgets/make%20outfit%20view/preview_outfit_list_view.dart';

class PreviewOutfitViewBody extends StatefulWidget {
  final OutfitModel outfit;
  const PreviewOutfitViewBody({super.key, required this.outfit});

  @override
  State<PreviewOutfitViewBody> createState() => _PreviewOutfitViewBodyState();
}

class _PreviewOutfitViewBodyState extends State<PreviewOutfitViewBody> {
  String imagePath = 'assets/images/image1.jpg';

  @override
  void initState() {
    imagePath = widget.outfit.clothes[0].url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutfitCubit, OutfitState>(
      listener: (context, state) {
        if (state is OutfitChange) {
          imagePath = state.clothes.url;
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Match your outfit",
              style: TextStyle(
                color: Color(0xffde6fa3),
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 100),
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffde6fa3),
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      widget.outfit.name,
                      style: const TextStyle(
                        color: Color(0xffde6fa3),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.network(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            PreviewOutfitListView(
              clothes: widget.outfit.clothes,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
