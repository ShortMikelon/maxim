import 'package:maxim/entities/profile.dart';

class RemoteDataSource {
  RemoteDataSource._();

  factory RemoteDataSource() {
    return _instance;
  }

  var _profile = const Profile(
    prof: 'Gachi-Muchi Boss',
    password: '1234',
  );

  Future<Profile> fetchTrainerData() {
    return Future.delayed(const Duration(seconds: 1), () => _profile);
  }

  Future<void> savePassword(String newPassword) async {
    return Future.delayed(const Duration(seconds: 1), () {
      _profile = _profile.copyWith(password: newPassword);
    });
  }

  static final RemoteDataSource _instance = RemoteDataSource._();
}