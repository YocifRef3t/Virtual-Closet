import 'package:dartz/dartz.dart';
import 'package:virtual_closet/core/errors/failure.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import '../../../../core/models/user_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<OutfitModel>>> fetchAllOutfits(MyUserModel user);
  ///////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, List<UserModel>>> fetchAllUsers(MyUserModel user);
  ///////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, List<OutfitModel>>> fetchUserOutfits(MyUserModel user);
  ///////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, List<OutfitModel>>> fetchFavorite(MyUserModel user);
  ///////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, Map<String, dynamic>>> search({
    required MyUserModel user,
    required String searchKey,
  });
  ///////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, bool>> createFavorite({
    required MyUserModel user,
    required String id,
  });
}
