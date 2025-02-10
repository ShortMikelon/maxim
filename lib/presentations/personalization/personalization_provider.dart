import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:maxim/data_sources/secure_storage.dart';

class PersonalizationProvider with ChangeNotifier {
  final _secureStorage = SecureStorage();

  String _clientName = '';
  String get clientName => _clientName;

  String _adminName = '';
  String get adminName => _adminName;

  String _eventName = '';
  String get eventName => _eventName;

  StreamSubscription<String?>? _clientNameSubscription;
  StreamSubscription<String?>? _adminNameSubscription;
  StreamSubscription<String?>? _eventNameSubscription;

  init() async {
    final clientName = await _secureStorage.getClientName();
    _clientName = clientName ?? clientDefaultName;

    final adminName = await _secureStorage.getAdminName();
    _adminName = adminName ?? adminDefaultName;

    final eventName = await _secureStorage.getEventName();
    _eventName = eventName ?? eventDefaultName;

    notifyListeners();
  }

  PersonalizationProvider() {
    init();

    _clientNameSubscription = _secureStorage.clientNameStream.listen((data) {
      _clientName = data ?? _clientName;
      notifyListeners();
    });

    _adminNameSubscription = _secureStorage.adminNameStream.listen((data) {
      _adminName = data ?? adminDefaultName;
      notifyListeners();
    });

    _eventNameSubscription = _secureStorage.eventNameStream.listen((data) {
      _eventName = data ?? eventDefaultName;
      notifyListeners();
    });
  }

  void changeClientName(String newValue) {
    _clientName = newValue;
    notifyListeners();
  }

  void changeAdminName(String newValue) {
    _adminName = newValue;
    notifyListeners();
  }

  void changeEventName(String newValue) {
    _eventName = newValue;
    notifyListeners();
  }

  @override
  void dispose() {
    _clientNameSubscription?.cancel();
    _adminNameSubscription?.cancel();
    _eventNameSubscription?.cancel();
    super.dispose();
  }

  static const clientDefaultName = 'Ученик';
  static const adminDefaultName = 'Тренер';
  static const eventDefaultName = 'Урок';
}