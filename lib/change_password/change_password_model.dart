import 'package:flutter/material.dart';
import 'package:maxim/data_sources/remote_storage.dart';

class ChangePasswordModel with ChangeNotifier {
  final _oldPasswordHelper = ChangePasswordFieldHelper(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    isVisible: false,
  );

  final _newPasswordHelper = ChangePasswordFieldHelper(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    isVisible: false,
  );

  final _repeatPasswordHelper = ChangePasswordFieldHelper(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    isVisible: false,
  );

  final _remoteDataSource = RemoteDataSource();

  late final String _correctOldPassword;

  String _errorMessage = '';

  bool _saveButtonIsEnabled = false;

  bool _passwordSavedIsCorrect = false;

  ChangePasswordModel() {
    _init();
    _registerFieldListener();
  }

  void save() {
    final oldPassword = _oldPasswordHelper.controller.text;
    final newPassword = _newPasswordHelper.controller.text;
    final repeatPassword = _repeatPasswordHelper.controller.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty) {
      _errorMessage = 'Error #1';
    } else if (oldPassword != _correctOldPassword) {
      _errorMessage = 'Error #2';
    } else if (!_validateNewPassword(newPassword)) {
      _errorMessage = 'Error #3';
    } else if (newPassword != repeatPassword) {
      _errorMessage = 'Error #4';
    } else {
      try {
        _remoteDataSource.savePassword(newPassword);
        _passwordSavedIsCorrect = true;
      } catch (ex) {
        _errorMessage = 'Error #5';
      }
    }

    notifyListeners();
  }

  void onChangeFieldVisibility(ChangePasswordField field) {
    if (field == ChangePasswordField.oldPassword) {
      _oldPasswordHelper.isVisible = !_oldPasswordHelper.isVisible;
    } else if (field == ChangePasswordField.newPassword) {
      _newPasswordHelper.isVisible = !_newPasswordHelper.isVisible;
    } else if (field == ChangePasswordField.repeatPassword) {
      _repeatPasswordHelper.isVisible = !_repeatPasswordHelper.isVisible;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _fieldsDispose();
    super.dispose();
  }

  ChangePasswordFieldHelper get oldPasswordHelper => _oldPasswordHelper;

  ChangePasswordFieldHelper get newPasswordHelper => _newPasswordHelper;

  ChangePasswordFieldHelper get repeatPasswordHelper => _repeatPasswordHelper;

  String get errorMessage => _errorMessage;

  bool get saveButtonIsEnabled => _saveButtonIsEnabled;

  bool get passwordSavedIsCorrect => _passwordSavedIsCorrect;

  bool _validateNewPassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(password);
  }

  void _registerFieldListener() {
    _oldPasswordHelper.focusNode.addListener(notifyListeners);
    _newPasswordHelper.focusNode.addListener(notifyListeners);
    _repeatPasswordHelper.focusNode.addListener(notifyListeners);


    _oldPasswordHelper.controller.addListener(_textControllerListener);
    _newPasswordHelper.controller.addListener(_textControllerListener);
    _repeatPasswordHelper.controller.addListener(_textControllerListener);
  }

  void _textControllerListener() {
    final oldPassword = _oldPasswordHelper.controller.text;
    final newPassword = _newPasswordHelper.controller.text;
    final repeatPassword = _repeatPasswordHelper.controller.text;

    _saveButtonIsEnabled = oldPassword.isNotEmpty
        && newPassword.isNotEmpty
        && repeatPassword.isNotEmpty;

    notifyListeners();
  }

  void _fieldsDispose() {
    _oldPasswordHelper.focusNode.removeListener(notifyListeners);
    _oldPasswordHelper.controller.removeListener(_textControllerListener);
    _oldPasswordHelper.focusNode.dispose();
    _oldPasswordHelper.controller.dispose();

    _newPasswordHelper.focusNode.removeListener(notifyListeners);
    _newPasswordHelper.controller.removeListener(_textControllerListener);
    _newPasswordHelper.focusNode.dispose();
    _newPasswordHelper.controller.dispose();

    _repeatPasswordHelper.focusNode.removeListener(notifyListeners);
    _repeatPasswordHelper.controller.removeListener(_textControllerListener);
    _repeatPasswordHelper.focusNode.dispose();
    _repeatPasswordHelper.controller.dispose();
  }

  void _init() async {
    _correctOldPassword = (await _remoteDataSource.fetchTrainerData()).password;
  }
}

class ChangePasswordFieldHelper {
  final TextEditingController controller;
  final FocusNode focusNode;
  bool isVisible;

  ChangePasswordFieldHelper({
    required this.controller,
    required this.focusNode,
    required this.isVisible,
  });

  ChangePasswordFieldHelper copyWith({bool? isVisible}) {
    return ChangePasswordFieldHelper(
      controller: controller,
      focusNode: focusNode,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

enum ChangePasswordField {
  oldPassword,
  newPassword,
  repeatPassword,
}