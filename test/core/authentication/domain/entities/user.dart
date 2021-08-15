import 'package:flutter_clean_auth_architecture/core/authentication/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Name name;

  setUp(() {
    name = Name(first: "Chaitanya", last: "Sharma");
  });
  final tName1 = "Chaitanya Sharma";
  final tName2 = "Chaitanya Sanjeev Sharma";
  final tName3 = "Chaitanya";

  test("should create valid instance from name string", () {
    expect(Name.fromString(tName1), name);
    expect(Name.fromString(tName1), isA<Name>());
  });

  test("should have middle name for a name string with middle name", () {
    final result = Name.fromString(tName2);
    expect(result.middle, tName2.split(' ')[1]);
    expect(result.middle, isA<String>());
  });

  test("should have last name for a name string with last name", () {
    final result = Name.fromString(tName2);
    expect(result.last, tName2.split(' ')[2]);
    expect(result.last, isA<String>());
  });

  test(
      "should not have a middle name for a name string with first and last name",
      () {
    final result = Name.fromString(tName1);
    expect(result.last, tName1.split(' ')[1]);
    expect(result.middle, null);
  });

  test(
      "should not have a middle name and last name for a name string with only first name",
      () {
    final result = Name.fromString(tName3);
    expect(result.last, null);
    expect(result.middle, null);
  });

  test("should throw exception for a name string as empty", () {
    expect(() => Name.fromString(""), throwsAssertionError);
    expect(() => Name.fromString(" "), throwsAssertionError);
    expect(() => Name.fromString("  "), throwsAssertionError);
  });

  test("should return a name string from toString() call", () {
    expect(name.toString(), tName1);
    expect(Name.fromString(tName2).toString(), tName2);
    expect(Name.fromString(tName3).toString(), tName3);
  });
}
