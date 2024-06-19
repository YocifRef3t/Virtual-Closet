import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/utls/app_router.dart';
import 'package:virtual_closet/core/utls/custom_snack_bar.dart';
import 'package:virtual_closet/feature/home/presentation/manage/home%20cubit/home_cubit.dart';

class CustomSearchBar extends StatefulWidget {
  final MyUserModel user;
  const CustomSearchBar({super.key, required this.user});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SearchLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is SearchSuccess) {
          isLoading = false;
          setState(() {});
          GoRouter.of(context).push(
            AppRouter.kSearchResultViewPath,
            extra: {
              'user': widget.user,
              'data': state.data,
            },
          );
        } else if (state is SearchFailure) {
          isLoading = false;
          setState(() {});
          ShowCustomSnackBar(context).warning(message: state.errorMessage);
        }
      },
      child: TextField(
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            if (value != "") {
              BlocProvider.of<HomeCubit>(context).search(
                user: widget.user,
                searchKey: value,
              );
            }
          }
        },
        decoration: InputDecoration(
          hintText: "Search",
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: !isLoading
              ? const Icon(Icons.search)
              : const Padding(
                  padding: EdgeInsets.all(15),
                  child: SizedBox(
                    width: 2,
                    height: 2,
                    child: CircularProgressIndicator(
                      color: Color(0xffde6fa3),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
