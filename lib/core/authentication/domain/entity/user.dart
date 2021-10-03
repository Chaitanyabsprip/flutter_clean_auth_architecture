import 'package:equatable/equatable.dart';

import 'credentials.dart';

class Name extends Equatable {
  final String first;
  final String? middle, last;

  const Name({
    required this.first,
    required this.last,
    this.middle,
  });

  factory Name.fromString(String fullName) {
    assert(validate(fullName));

    final List<String> nameList = fullName.split(" ");
    String? middleName, lastName;

    if (nameList.length == 3) {
      lastName = nameList[2];
      middleName = nameList[1];
    } else if (nameList.length == 2) {
      lastName = nameList[1];
    }

    return Name(first: nameList[0], last: lastName, middle: middleName);
  }

  @override
  List<Object?> get props => [first, middle ?? "", last ?? ""];

  @override
  String toString() {
    late String fullName;
    if (last == null)
      fullName = "$first";
    else if (middle == null)
      fullName = "$first $last";
    else
      fullName = "$first $middle $last";

    return fullName;
  }

  static bool validate(String fullName) {
    final String regex =
        r"^[^\ ].*[\w'\-,.]*[^_!¡?÷?¿\/\\+=@#$%ˆ&*(){}|~<>;:[\]]*$";
    final bool valid = RegExp(regex).hasMatch(fullName);
    return valid;
  }
}

class User extends Equatable {
  bool emailVerified;
  final Email email;
  final Name? name;
  final String uid;
  final int? age;

  User({
    required this.age,
    this.name,
    required this.email,
    required this.uid,
    this.emailVerified = false,
  });

  @override
  List<Object?> get props => [uid];

  @override
  bool get stringify => true;
}
