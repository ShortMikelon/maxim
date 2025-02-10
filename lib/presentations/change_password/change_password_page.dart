import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maxim/app_string_resources.dart';
import 'package:maxim/app_color_resources.dart';
import 'package:maxim/presentations/change_password/change_password_model.dart';
import 'package:maxim/widgets/app_button.dart';
import 'package:maxim/widgets/app_text_styles.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _ChangePasswordBody(),
    );
  }
}

class _ChangePasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordModel(),
      child: Consumer<ChangePasswordModel>(
        builder: (context, model, child) {
          if (model.passwordSavedIsCorrect) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStringResources.passwordSuccessChanged), duration: Duration(seconds: 1)),
              );
              Navigator.pop(context);
            });

          }


          return Container(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      AppStringResources.changePassword,
                      style: AppTextStyles.boldTextStyle,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8),
                    _ChangePasswordField(
                      label: AppStringResources.oldPassword,
                      helper: model.oldPasswordHelper,
                      changeVisibility: () {
                        model.onChangeFieldVisibility(
                          ChangePasswordField.oldPassword,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _ChangePasswordField(
                      label: AppStringResources.newPassword,
                      helper: model.newPasswordHelper,
                      changeVisibility: () {
                        model.onChangeFieldVisibility(
                          ChangePasswordField.newPassword,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _ChangePasswordField(
                      label: AppStringResources.repeatPassword,
                      helper: model.repeatPasswordHelper,
                      changeVisibility: () {
                        model.onChangeFieldVisibility(
                          ChangePasswordField.repeatPassword,
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: model.errorMessage.isNotEmpty,
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 70),
                        decoration: BoxDecoration(
                          color: AppColorResources.errorRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(model.errorMessage,
                            style: const TextStyle(color: AppColorResources.white)),
                      ),
                    ),
                    Visibility(
                      visible: model.errorMessage.isNotEmpty,
                      child: const SizedBox(height: 8),
                    ),
                    AppButton(
                      background: AppColorResources.blue,
                      onPressed: model.saveButtonIsEnabled ? model.save : null,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppStringResources.save,
                          style: TextStyle(
                            color: model.saveButtonIsEnabled
                                ? AppColorResources.white
                                : AppColorResources.lightGray,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ChangePasswordField extends StatelessWidget {
  final String label;
  final ChangePasswordFieldHelper helper;
  final void Function() changeVisibility;

  const _ChangePasswordField({
    required this.label,
    required this.helper,
    required this.changeVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        helper.focusNode.hasFocus ? AppColorResources.blue : AppColorResources.white;

    final visibilityIcon = helper.isVisible
        ? const Icon(CupertinoIcons.eye_fill, color: AppColorResources.black)
        : const Icon(CupertinoIcons.eye_slash_fill, color: AppColorResources.lightGray);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 58,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: AppColorResources.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              cursorHeight: 20,
              cursorWidth: 1,
              cursorColor: AppColorResources.lightGray,
              controller: helper.controller,
              focusNode: helper.focusNode,
              obscureText: !helper.isVisible,
              keyboardType: TextInputType.visiblePassword,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                labelText: label,
                labelStyle: AppTextStyles.hintTextStyle,
                filled: true,
                fillColor: AppColorResources.white,
              ),
              style: AppTextStyles.blackTextStyle,
            ),
          ),
          IconButton(onPressed: changeVisibility, icon: visibilityIcon)
        ],
      ),
    );
  }
}
