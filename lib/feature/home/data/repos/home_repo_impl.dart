import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:virtual_closet/core/errors/failure.dart';
import 'package:virtual_closet/core/models/clothe_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/user_model.dart';
import 'package:virtual_closet/feature/home/data/repos/home_repo.dart';
import 'package:virtual_closet/helper/api_helper.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, List<OutfitModel>>> fetchAllOutfits(
      MyUserModel user) async {
    try {
      List<OutfitModel> outfitList = [];
      var response = await APIHelper().get(
        url: "https://abdelnaby.store/api/store",
        token: user.token,
      );
      var data = jsonDecode(response.body);
      if (data['status']) {
        for (var outfit in data['data']) {
          List<ClotheModel> clothesList = [];
          for (var clothes in outfit['media']) {
            clothesList.add(
              ClotheModel(id: clothes['id'], url: clothes['original_url']),
            );
          }
          outfitList.add(
            OutfitModel(
              id: outfit['id'],
              favorite: outfit['favorite'],
              name: outfit['name'],
              description: outfit['description'],
              clothes: clothesList,
            ),
          );
        }
        return right(outfitList);
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> fetchAllUsers(
      MyUserModel user) async {
    try {
      List<UserModel> users = [];
      var response = await APIHelper().get(
        url: "https://abdelnaby.store/api/users",
        token: user.token,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status']) {
          for (var user in data['data']) {
            users.add(
              UserModel(
                id: user['id'],
                photoURL: user['media'][0]['original_url'],
                name: user['name'],
                email: user['email'],
                phone: user['phone'],
              ),
            );
          }
          return right(users);
        } else {
          return left(Failure(errorMessage: "Something went wrong"));
        }
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OutfitModel>>> fetchUserOutfits(
      MyUserModel user) async {
    try {
      List<OutfitModel> outfitList = [];
      var response = await APIHelper().get(
        url: "https://abdelnaby.store/api/store?user=me",
        token: user.token,
      );
      var data = jsonDecode(response.body);
      if (data['status']) {
        for (var outfit in data['data']) {
          List<ClotheModel> clothesList = [];
          for (var clothes in outfit['media']) {
            clothesList.add(
              ClotheModel(id: clothes['id'], url: clothes['original_url']),
            );
          }
          outfitList.add(
            OutfitModel(
              id: outfit['id'],
              favorite: outfit['favorite'],
              name: outfit['name'],
              description: outfit['description'],
              clothes: clothesList,
            ),
          );
        }
        return right(outfitList);
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OutfitModel>>> fetchFavorite(
      MyUserModel user) async {
    try {
      List<OutfitModel> outfitList = [];
      var response = await APIHelper().get(
        url: "https://abdelnaby.store/api/favorite",
        token: user.token,
      );
      var data = jsonDecode(response.body);
      if (data['status']) {
        for (var outfit in data['data']) {
          List<ClotheModel> clothesList = [];
          for (var clothes in outfit['media']) {
            clothesList.add(
              ClotheModel(id: clothes['id'], url: clothes['original_url']),
            );
          }
          outfitList.add(
            OutfitModel(
              id: outfit['id'],
              favorite: true,
              name: outfit['name'],
              description: outfit['description'],
              clothes: clothesList,
            ),
          );
        }
        return right(outfitList);
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createFavorite(
      {required MyUserModel user, required String id}) async {
    try {
      var response = await APIHelper().post(
        url: "https://abdelnaby.store/api/favorite",
        body: {
          'id': id,
        },
        token: user.token,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status']) {
          return right(true);
        } else {
          return left(Failure(errorMessage: "Something went wrong"));
        }
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (e) {
      return left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> search(
      {required MyUserModel user, required String searchKey}) async {
    try {
      List<OutfitModel> outfitList = [];
      List<UserModel> userList = [];
      var response = await APIHelper().get(
        url: "https://abdelnaby.store/api/store?search=$searchKey",
        token: user.token,
      );
      var data = jsonDecode(response.body);
      if (data['status']) {
        for (var user1 in data['users']) {
          userList.add(
            UserModel(
              id: user1['id'],
              photoURL: user1['media'][0]['original_url'],
              name: user1['name'],
              email: user1['email'],
              phone: user1['phone'],
            ),
          );
        }
        for (var outfit in data['data']) {
          List<ClotheModel> clothesList = [];
          for (var clothes in outfit['media']) {
            clothesList.add(
              ClotheModel(id: clothes['id'], url: clothes['original_url']),
            );
          }
          outfitList.add(
            OutfitModel(
              id: outfit['id'],
              favorite: outfit['favorite'],
              name: outfit['name'],
              description: outfit['description'],
              clothes: clothesList,
            ),
          );
        }
        return right({
          'userList': userList,
          'outFitList': outfitList,
        });
      } else {
        return left(Failure(errorMessage: "Something went wrong"));
      }
    } on Exception catch (ex) {
      return left(Failure(errorMessage: ex.toString()));
    }
  }
}
