import '../../domain/entity/credentials.dart';
import '../../domain/entity/user.dart';

class NullUser extends UserModel {
  NullUser()
      : super(
          age: 0,
          email: Email('nullUser@example.com'),
          name: const Name(first: 'Null', last: 'Null'),
          uid: 'Null',
        );
}

class UserModel extends User {
  UserModel({
    Name? name,
    bool emailVerified = false,
    int? age,
    required Email email,
    required String uid,
  }) : super(
          age: age,
          email: email,
          emailVerified: emailVerified,
          name: name,
          uid: uid,
        );

  factory UserModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserModel(
        age: jsonMap['age'],
        email: Email(jsonMap['email']),
        name: Name.fromString(jsonMap["name"]),
        uid: jsonMap['uid']);
  }

  Map get toJson {
    return {
      'age': age,
      'email': email.value,
      'emailVerified': emailVerified,
      'name': name.toString(),
      'uid': uid,
    };
  }
}
