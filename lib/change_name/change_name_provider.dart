import 'package:flutter/material.dart';
import 'package:maxim/change_name/default_names.dart';
import 'package:maxim/change_name/name_type.dart';
import 'package:maxim/data_sources/secure_storage.dart';

final class ChangeNameProvider with ChangeNotifier {
  final secureStorage = SecureStorage();

  String _groupValue = '';

  String get groupValue => _groupValue;

  bool saveActionIsEnabled = false;

  bool get otherFieldIsVisible => _groupValue == DefaultNames.other;

  final TextEditingController controller = TextEditingController();

  final NameType nameType;

  ChangeNameProvider({
    required this.nameType,
  }) {
    controller.addListener(() {
      saveActionIsEnabled = controller.text.isNotEmpty;
      notifyListeners();
    });
  }

  void groupValueOnChanged(String newValue) {
    _groupValue = newValue;
    saveActionIsEnabled = _groupValue.isNotEmpty &&
        (!otherFieldIsVisible || controller.text.isNotEmpty);

    notifyListeners();
  }

  void save() {
    var newName = otherFieldIsVisible ? controller.text : _groupValue;

    if (nameType == NameType.client) {
      secureStorage.setClientName(newName);
    } else if (nameType == NameType.admin) {
      secureStorage.setAdminName(newName);
    } else {
      secureStorage.setEventName(newName);
    }
  }
}
