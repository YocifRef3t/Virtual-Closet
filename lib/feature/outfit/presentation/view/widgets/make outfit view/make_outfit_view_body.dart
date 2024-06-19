import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/utls/custom_snack_bar.dart';
import 'package:virtual_closet/core/widgets/custom_button.dart';
import 'package:virtual_closet/core/widgets/custom_text_field.dart';
import 'package:virtual_closet/feature/home/presentation/manage/home%20cubit/home_cubit.dart';
import 'package:virtual_closet/feature/outfit/presentation/manage/outfit%20cubit/outfit_cubit.dart';
import 'make_outfit_list_view_item.dart';

class MakeOutFitViewBody extends StatefulWidget {
  final MyUserModel user;
  const MakeOutFitViewBody({super.key, required this.user});

  @override
  State<MakeOutFitViewBody> createState() => _MakeOutFitViewBodyState();
}

class _MakeOutFitViewBodyState extends State<MakeOutFitViewBody> {
  bool isLoading = false;
  List<File> files = [];
  int flag = 1;
  @override
  Widget build(BuildContext context) {
    return BlocListener<OutfitCubit, OutfitState>(
      listener: (context, state) {
        if (state is UploadImagesLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is UploadImagesSuccess) {
          isLoading = false;
          setState(() {});
          BlocProvider.of<HomeCubit>(context).fetchAllOutfits(widget.user);
          GoRouter.of(context).pop();
          ShowCustomSnackBar(context).done(
            message: "Outfit has been uploaded successfully",
          );
        } else if (state is UploadImagesFailure) {
          isLoading = false;
          setState(() {});
          ShowCustomSnackBar(context).failure(
            message: state.errorMessage,
          );
        } else if (state is GetOutfitSuccess) {
          files = state.files;
          setState(() {});
        } else if (state is ChangeFlag) {
          setState(() {
            flag = state.flag;
          });
        } else {
          isLoading = false;
          setState(() {});
        }
      },
      child: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: Color(0xffde6fa3),
        ),
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              CustomTextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (value != "") {
                      BlocProvider.of<OutfitCubit>(context).name = value;
                    } else {
                      BlocProvider.of<OutfitCubit>(context).name = null;
                    }
                  } else {
                    BlocProvider.of<OutfitCubit>(context).name = null;
                  }
                },
                hintText: "Name (required)",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (value != "") {
                      BlocProvider.of<OutfitCubit>(context).description = value;
                    } else {
                      BlocProvider.of<OutfitCubit>(context).description = null;
                    }
                  } else {
                    BlocProvider.of<OutfitCubit>(context).description = null;
                  }
                },
                hintText: "Describe your outfit (required)",
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Select your clothes",
                          style: TextStyle(
                            color: Color(0xffde6fa3),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<OutfitCubit>(context).getImages();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color(0xffde6fa3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(thickness: 1),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: files.length,
                        itemBuilder: (context, index) => MakeOutfitListViewItem(
                          image: files[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Public",
                      onPressed: () {
                        BlocProvider.of<OutfitCubit>(context).changeFlag(0);
                      },
                      backgroundColor: flag == 1
                          ? const Color(0xffc10776)
                          : Colors.transparent,
                      border: flag == 1
                          ? null
                          : Border.all(
                              width: 1,
                              color: const Color(0xffc10776),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: "Private",
                      backgroundColor: flag == 0
                          ? const Color(0xffc10776)
                          : Colors.transparent,
                      border: flag == 0
                          ? null
                          : Border.all(
                              width: 1,
                              color: const Color(0xffc10776),
                            ),
                      onPressed: () {
                        BlocProvider.of<OutfitCubit>(context).changeFlag(1);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
