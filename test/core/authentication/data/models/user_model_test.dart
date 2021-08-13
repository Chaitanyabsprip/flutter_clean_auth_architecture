import 'package:crimson/core/authentication/data/models/user_model.dart';
import 'package:crimson/core/authentication/domain/entity/credentials.dart';
import 'package:crimson/core/authentication/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserModel userModel;
  late Map<String, dynamic> tUserModelJson;

  setUp(() {
    userModel = UserModel(
      age: 22,
      email: Email('chaitanyasanjeevsharma@gmail.com'),
      emailVerified: true,
      name: Name.fromString('Chaitanya Sharma'),
      uid: 'uniqueID',
    );

    tUserModelJson = {
      'age': 22,
      'email': Email('chaitanyasanjeevsharma@gmail.com').toString(),
      'emailVerified': true,
      'name': Name.fromString('Chaitanya Sharma').toString(),
      'uid': 'uniqueID',
    };
  });

  test("should be a sub class of User", () {
    expect(userModel, isA<User>());
  });

  test("should create a valid UserModel from json", () {
    final result = UserModel.fromJson(tUserModelJson);
    expect(result, userModel);
  });
}
