class UserModel {
  final int id;
  final String photoURL;
  final String name;
  final String email;
  final String? phone;
  UserModel({
    required this.id,
    required this.photoURL,
    required this.name,
    required this.email,
    required this.phone,
  });
}
