import 'package:hive/hive.dart';

part 'user_model.g.dart'; // الملف التوأم (g = generated)

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  UserModel({required this.name, required this.image});
}
