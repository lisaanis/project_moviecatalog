import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class DataModel {

  DataModel({required this.firstname, required this.lastname, required this.email, required this.password});
  @HiveField(0)
  String firstname;

  @HiveField(1)
  String lastname;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  @override
  String toString() {
    return 'DataModel{firstname: $firstname, lastname: $lastname, email: $email, password: $password}';
  }
}