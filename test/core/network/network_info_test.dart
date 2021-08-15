import 'package:flutter_clean_auth_architecture/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockInternetChecker internetChecker;
  late NetworkInfo networkInfo;

  setUp(() {
    internetChecker = MockInternetChecker();
    networkInfo = NetworkInfoImpl(internetChecker);
  });

  test("should return true if internet is connected", () async {
    when(() => internetChecker.hasConnection).thenAnswer((_) async => true);
    expect(await networkInfo.isConnected, true);
  });

  test("should return false if internet is not connected", () async {
    when(() => internetChecker.hasConnection).thenAnswer((_) async => false);
    expect(await networkInfo.isConnected, false);
  });
}

class MockInternetChecker extends Mock implements InternetConnectionChecker {}
