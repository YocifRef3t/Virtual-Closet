import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/utls/app_router.dart';

class RecommendedItem extends StatelessWidget {
  final MyUserModel user;
  final OutfitModel outfit;
  const RecommendedItem({super.key, required this.outfit, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          AppRouter.kPreviewOutfitViewPath,
          extra: {
            'outfit': outfit,
            'user': user,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(outfit.clothes[0].url),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.bottomRight,
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          child: Icon(
            Icons.favorite,
            color: outfit.favorite ? Colors.red : Colors.white,
          ),
        ),
      ),
      // child: Stack(
      //   children: [
      //     Center(
      //       child: Image.network(outfit.clothes[0].url),
      //     ),
      //     Expanded(
      //       child: Container(
      //         padding: const EdgeInsets.all(5),
      //         width: double.maxFinite,
      //         height: double.maxFinite,
      //         alignment: Alignment.bottomRight,
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             colors: [
      //               Colors.black.withOpacity(0.0),
      //               Colors.black.withOpacity(0.2),
      //               Colors.black.withOpacity(0.8),
      //             ],
      //           ),
      //         ),
      //         child: Icon(
      //           Icons.favorite,
      //           color: outfit.favorite ? Colors.red : Colors.white,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
