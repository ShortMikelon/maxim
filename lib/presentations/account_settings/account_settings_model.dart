import 'package:flutter/material.dart';
import 'package:maxim/data_sources/remote_storage.dart';
import 'package:maxim/data_sources/secure_storage.dart';

class AccountSettingsModel with ChangeNotifier {
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final _storage = SecureStorage();
  final _remoteDataSource = RemoteDataSource();

  String _profession = '';

  bool _isLoading = true;

  AccountSettingsModel() {
    usernameFocusNode.addListener(notifyListeners);
    phoneNumberFocusNode.addListener(notifyListeners);

    phoneNumberController.addListener(_formatPhoneNumber);

    init();
  }

  void init() async {
    usernameController.text = await _storage.getUsername() ?? '';
    phoneNumberController.text = (await _storage.getPhoneNumber() ?? '');
    _profession = (await _remoteDataSource.fetchTrainerData()).prof;

    _isLoading = false;
    notifyListeners();
  }

  void saveData() {
    _storage.setUsername(usernameController.text);

    _storage.setPhoneNumber(phoneNumberController.text);
  }

  @override
  void dispose() {
    usernameFocusNode.removeListener(notifyListeners);
    usernameController.dispose();
    usernameFocusNode.dispose();

    phoneNumberFocusNode.removeListener(notifyListeners);
    phoneNumberController.dispose();
    phoneNumberFocusNode.dispose();

    super.dispose();
  }

  String get profession => _profession;

  bool get isLoading => _isLoading;

  void _formatPhoneNumber() {
    String text = phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

    if (text.isEmpty) {
      if (phoneNumberController.text.isNotEmpty) {
        phoneNumberController.text = '';
      }
      return;
    }

    bool startsWithEight = text.startsWith("8");
    bool startsWithSevenOrPlus = text.startsWith("7") || text.startsWith("+");
    if (!startsWithEight) {
      text = "+7${text.substring(1)}";
    }

    if (startsWithEight && text.length > 11) {
      text = text.substring(0, 11);
    } else if (startsWithSevenOrPlus && text.length > 12) {
      text = text.substring(0, 12);
    }

    String formattedText = startsWithEight ? "8" : "+7";
    int offset = startsWithEight ? 1 : 2;

    if (text.length > offset) formattedText += " ${text.substring(offset, text.length >= offset + 3 ? offset + 3 : text.length)}";
    if (text.length > offset + 3) formattedText += " ${text.substring(offset + 3, text.length >= offset + 6 ? offset + 6 : text.length)}";
    if (text.length > offset + 6) formattedText += " ${text.substring(offset + 6, text.length >= offset + 8 ? offset + 8 : text.length)}";
    if (text.length > offset + 8) formattedText += " ${text.substring(offset + 8)}";


    phoneNumberController.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

enum AccountSettingsField {
  username,
  phoneNumber,
}
