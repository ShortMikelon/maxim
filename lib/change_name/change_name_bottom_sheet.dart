import 'package:flutter/material.dart';
import 'package:maxim/change_client_name_constants.dart';
import 'package:maxim/change_name/change_name_provider.dart';
import 'package:maxim/name_type.dart';
import 'package:maxim/widgets/app_text_styles.dart';
import 'package:provider/provider.dart';

void showChangeNameBottomSheet({
  required BuildContext context,
  required List<String> options,
  required NameType nameType,
  required String headerTitle,
  required String fieldHint,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return ChangeNotifierProvider(
        create: (context) => ChangeNameProvider(nameType: nameType),
        child: Consumer<ChangeNameProvider>(
          builder: (context, provider, child) {
            void Function()? saveButtonOnPressed;
            if (provider.saveActionIsEnabled) {
              saveButtonOnPressed = provider.save;
            }

            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _AppBottomSheetHeader(title: headerTitle),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 8,
                    ),
                    child: Column(
                      children: <Widget>[
                        ...options.map((option) {
                          return _AppRadioButton(
                            text: option,
                            value: option,
                            groupValue: provider.groupValue,
                            onSelected: (newValue) {
                              if (newValue != null) {
                                provider.groupValueOnChanged(newValue);
                              }
                            },
                          );
                        }),
                        Visibility(
                          visible: provider.otherFieldIsVisible,
                          child: _AppTextField(
                            labelName: fieldHint,
                            textEditingController: provider.controller,
                            onSubmit: (_) {
                              if (saveButtonOnPressed != null) {
                                saveButtonOnPressed();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  _AppSaveButton(onPressed: saveButtonOnPressed),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class _AppBottomSheetHeader extends StatelessWidget {
  final String title;

  const _AppBottomSheetHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppTextStyles.bottomSheetTopBarTextStyle,
            ),
          ),
        )
      ],
    );
  }
}

class _AppSaveButton extends StatelessWidget {
  final void Function()? onPressed;

  const _AppSaveButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool isEnabled = onPressed != null;

    void Function()? onPressedWithPopBack;
    if (isEnabled) {
      onPressedWithPopBack = () {
        onPressed!();
        Navigator.pop(context);
      };
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 16, left: 16),
      child: ElevatedButton(
        onPressed: onPressedWithPopBack,
        style: ElevatedButton.styleFrom().copyWith(
          minimumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(56)),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return ChangeClientNameConstants.spitsbergenBlue;
              }

              return ChangeClientNameConstants.blue;
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          'Сохранить',
          style: TextStyle(
            color:
            isEnabled ? Colors.white : ChangeClientNameConstants.lightGray,
          ),
        ),
      ),
    );
  }
}

class _AppTextField extends StatelessWidget {
  final String labelName;
  final ValueChanged<String> onSubmit;
  final TextEditingController textEditingController;

  const _AppTextField({
    required this.labelName,
    required this.textEditingController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 343,
      height: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ChangeClientNameConstants.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        style: AppTextStyles.blackTextStyle,
        onSubmitted: (value) {
          onSubmit(value);

          Navigator.pop(context);
        },
        controller: textEditingController,
        cursorColor: ChangeClientNameConstants.blue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
          labelText: labelName,
          labelStyle: AppTextStyles.hintTextStyle,
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class _AppRadioButton extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onSelected;

  const _AppRadioButton({
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onSelected(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: <Widget>[
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isSelected ? ChangeClientNameConstants.lightBlue : Colors.white,
                border: Border.all(color: ChangeClientNameConstants.lightGray20),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2),
              ),
              child: isSelected
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 12,
              )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyles.bottomSheetMainTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
