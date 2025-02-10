import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  final _clientNameController = StreamController<String?>.broadcast();
  final _adminNameController = StreamController<String?>.broadcast();
  final _eventNameController = StreamController<String?>.broadcast();

  SecureStorage._();

  static final SecureStorage _instance = SecureStorage._();

  factory SecureStorage() {
    return _instance;
  }

  Stream<String?> get clientNameStream => _clientNameController.stream;
  Stream<String?> get adminNameStream => _adminNameController.stream;
  Stream<String?> get eventNameStream => _eventNameController.stream;

  Future<void> setClientName(String? clientName) async {
    await _storage.write(key: _clientNameKey, value: clientName);
    _clientNameController.add(clientName);
  }

  Future<void> setAdminName(String? adminName) async {
    await _storage.write(key: _adminNameKey, value: adminName);
    _adminNameController.add(adminName);
  }

  Future<void> setEventName(String? eventName) async {
    await _storage.write(key: _eventNameKey, value: eventName);
    _eventNameController.add(eventName);
  }

  Future<void> setUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  Future<void> setPhoneNumber(String phoneNumber) async {
    await _storage.write(key: _phoneNumberKey, value: phoneNumber);
  }

  Future<void> saveLogin(String newLogin) async {
    await _storage.write(key: _loginKey, value: newLogin);
  }

  Future<void> saveProfession(String newProfession) async {
    await _storage.write(key: _professionKey, value: newProfession);
  }

  Future<String?> getClientName() {
    return _storage.read(key: _clientNameKey);
  }

  Future<String?> getAdminName() {
    return _storage.read(key: _adminNameKey);
  }

  Future<String?> getEventName() {
    return _storage.read(key: _eventNameKey);
  }

  Future<String?> getUsername() {
    return _storage.read(key: _usernameKey);
  }

  Future<String?> getPhoneNumber() {
    return _storage.read(key: _phoneNumberKey);
  }

  Future<String?> fetchLogin()  {
    return _storage.read(key: _loginKey);
  }

  Future<String?> fetchPassword() {
    return _storage.read(key: _passwordKey);
  }

  Future<String?> fetchProfession() {
    return _storage.read(key: _professionKey);
  }

  void dispose() {
    _clientNameController.close();
    _adminNameController.close();
    _eventNameController.close();
  }

  static const _usernameKey = 'username';
  static const _clientNameKey = 'clientName';
  static const _adminNameKey = 'adminName';
  static const _eventNameKey = 'eventName';
  static const _phoneNumberKey = 'phoneNumber';
  static const _loginKey = 'login';
  static const _professionKey = 'profession';
  static const _passwordKey = 'password';
}
