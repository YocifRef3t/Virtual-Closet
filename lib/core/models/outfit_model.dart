import 'package:virtual_closet/core/models/clothe_model.dart';

class OutfitModel {
  final int id;
  final bool favorite;
  final String name;
  final String description;
  final List<ClotheModel> clothes;
  OutfitModel({
    required this.id,
    required this.favorite,
    required this.name,
    required this.description,
    required this.clothes,
  });
}
