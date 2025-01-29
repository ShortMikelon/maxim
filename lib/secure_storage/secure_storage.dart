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

  Future<String?> getClientName() async {
    return await _storage.read(key: _clientNameKey);
  }

  Future<String?> getAdminName() async {
    return await _storage.read(key: _adminNameKey);
  }

  Future<String?> getEventName() async {
    return await _storage.read(key: _eventNameKey);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  Future<String?> getPhoneNumber() async {
    return await _storage.read(key: _phoneNumberKey);
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
}
