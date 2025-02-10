import 'package:flutter/material.dart';
import 'package:maxim/app_string_resources.dart';
import 'package:maxim/presentations/change_password/change_password_page.dart';
import 'package:maxim/widgets/app_button.dart';
import 'package:maxim/widgets/app_shimmer.dart';
import 'package:maxim/widgets/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'account_settings_model.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AccountSettingsAppBar(),
      body: _AccountSettingsBody(),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _AccountSettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: const Text(
        AppStringResources.accountSettings,
        style: AppTextStyles.appBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AccountSettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountSettingsModel(),
      child: Consumer<AccountSettingsModel>(
        builder: (context, model, child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: model.isLoading
              ? _AccountSettingsPendingBody()
              : _AccountSettingsDisplayBody(
                  usernameController: model.usernameController,
                  phoneNumberController: model.phoneNumberController,
                  usernameFocusNode: model.usernameFocusNode,
                  phoneNumberFocusNode: model.phoneNumberFocusNode,
                  profession: model.profession,
                  onSaveButtonPressed: model.saveData,
                ),
        ),
      ),
    );
  }
}

class _AccountSettingsPendingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          AppShimmer(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppShimmer(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppShimmer(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppShimmer(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ]),
        AppShimmer(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }
}

class _AccountSettingsDisplayBody extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final String profession;
  final FocusNode usernameFocusNode;
  final FocusNode phoneNumberFocusNode;
  final void Function() onSaveButtonPressed;

  const _AccountSettingsDisplayBody({
    required this.usernameController,
    required this.phoneNumberController,
    required this.usernameFocusNode,
    required this.phoneNumberFocusNode,
    required this.profession,
    required this.onSaveButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            _AccountSettingsInputField(
              label: AppStringResources.name,
              controller: usernameController,
              focusNode: usernameFocusNode,
            ),
            const SizedBox(height: 8),
            _AccountSettingsInputField(
              label: AppStringResources.phoneNumber,
              controller: phoneNumberController,
              focusNode: phoneNumberFocusNode,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            _AccountSettingsPasswordButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChangePasswordPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _AccountSettingsProfessionButton(profession: profession),
          ],
        ),
        AppButton(
          background: const Color(0xFF0062FF),
          onPressed: onSaveButtonPressed,
          child: const Align(
            alignment: Alignment.center,
            child: Text(AppStringResources.save, style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class _AccountSettingsInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;

  const _AccountSettingsInputField({
    required this.label,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        focusNode.hasFocus ? const Color(0xFF0062FF) : Colors.white;
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 2),
        color: Colors.white,
      ),
      child: TextField(
        cursorHeight: 20,
        cursorWidth: 1,
        cursorColor: const Color(0xFF0062FF),
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: InputBorder.none,
          labelText: label,
          labelStyle: AppTextStyles.hintTextStyle,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(
            Icons.border_color,
            size: 18.75,
            color: Color(0xFF8C8C8C),
          ),
        ),
        style: AppTextStyles.blackTextStyle,
      ),
    );
  }
}

class _AccountSettingsPasswordButton extends StatelessWidget {
  final void Function() onPressed;

  const _AccountSettingsPasswordButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      background: Colors.white,
      onPressed: onPressed,
      child: const Align(
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(AppStringResources.password, style: AppTextStyles.mainTextStyle),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Color(0xFF8C8C8C),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountSettingsProfessionButton extends StatelessWidget {
  final String profession;

  const _AccountSettingsProfessionButton({
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      background: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(AppStringResources.profession, style: AppTextStyles.mainTextStyle),
                Text(profession, style: AppTextStyles.hintTextStyle),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 17,
            color: Color(0xFF8C8C8C),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}