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
    required Email email,
    required Name name,
    required String uid,
    bool emailVerified = false,
    int? age,
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
        name: Name(
          first: jsonMap['name']['first'],
          middle: jsonMap['name']['first'],
          last: jsonMap['name']['last'],
        ),
        uid: jsonMap['uid']);
  }

  Map get toJson {
    return {
      'age': age,
      'email': email.toString(),
      'emailVerified': emailVerified,
      'name': {
        'first': name.first,
        'middle': name.middle,
        'last': name.last,
      },
      'uid': uid,
    };
  }
}
