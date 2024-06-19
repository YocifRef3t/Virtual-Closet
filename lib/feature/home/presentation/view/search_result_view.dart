import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/models/user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/home%20view/person_item.dart';
import 'package:virtual_closet/feature/home/presentation/view/widgets/home%20view/recommended_list_view.dart';

class SearchResultView extends StatefulWidget {
  final MyUserModel user;
  final Map<String, dynamic> data;
  const SearchResultView({super.key, required this.data, required this.user});

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  List<OutfitModel> outfitList = [];
  List<UserModel> userList = [];
  @override
  void initState() {
    outfitList = widget.data['outFitList'];
    userList = widget.data['userList'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Search Result",
          style: TextStyle(
            color: Color(0xffde6fa3),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xffde6fa3),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Visibility(
              visible: outfitList.isNotEmpty,
              child: SizedBox(
                height: 90,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: userList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PersonItem(
                      user: userList[index],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: userList.isNotEmpty,
              child: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height - 218,
                child: RecommendedListView(
                  outfits: outfitList,
                  user: widget.user,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
