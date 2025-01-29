import 'package:flutter/widgets.dart';
import 'package:maxim/secure_storage/secure_storage.dart';

final class ProfileProvider with ChangeNotifier {
  final SecureStorage _storage = SecureStorage();

  ProfileState _state = const PendingState();

  ProfileState get state => _state;

  ProfileProvider() {
    init();
    _storage.adminNameStream.listen((data) {
      if (_state is DataState) {
        final dataState = _state as DataState;
        _state = dataState.copyWith(status: data);
        notifyListeners();
      }
    });
  }

  init() async {
    await Future.delayed(const Duration(seconds: 5));

    final status = await _storage.getAdminName() ?? '';
    final username = await _storage.getUsername() ?? '';
    final phoneNumber = await _storage.getPhoneNumber() ?? '';

    _state = DataState(username: username, phoneNumber: phoneNumber, status: status);

    notifyListeners();
  }
}

sealed class ProfileState  {
  const ProfileState();
}

final class PendingState implements ProfileState  {
  const PendingState();
}

final class DataState extends ProfileState {
  final String username;
  final String phoneNumber;
  final String status;

  const DataState({
    required this.username,
    required this.phoneNumber,
    required this.status,
  });

  DataState copyWith({
    String? username,
    String? phoneNumber,
    String? status,
  }) {
    return DataState(
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }
}
