import 'package:flutter/material.dart';
import 'package:maxim/app_string_resources.dart';
import 'package:maxim/presentations/change_name/change_name_bottom_sheet.dart';
import 'package:maxim/presentations/change_name/default_names.dart';
import 'package:maxim/presentations/change_name/name_type.dart';
import 'package:maxim/presentations/personalization/personalization_provider.dart';
import 'package:maxim/widgets/app_button.dart';
import 'package:maxim/widgets/app_text_styles.dart';
import 'package:provider/provider.dart';

class PersonalizationPage extends StatelessWidget {
  const PersonalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonalizationProvider(),
      child: Scaffold(
        appBar: _PersonalizationAppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _PersonalizationBody(),
        ),
      ),
    );
  }
}

class _PersonalizationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStringResources.personalization,
          style: AppTextStyles.appBarTextStyle,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, size: 24),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PersonalizationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalizationProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            AppStringResources.howDoYouLikeIt,
            style: AppTextStyles.boldTextStyle,
          ),
          const SizedBox(height: 8),
          _PersonalizationButton(
            text: AppStringResources.clientName,
            value: provider.clientName,
            onPressed: () {
              showChangeNameBottomSheet(
                context: context,
                headerTitle: AppStringResources.clientName,
                fieldHint: AppStringResources.clientName,
                options: DefaultNames.clientNames,
                nameType: NameType.client,
              );
            },
          ),
          const SizedBox(height: 8),
          _PersonalizationButton(
            text: AppStringResources.adminName,
            value: provider.adminName,
            onPressed: () {
              showChangeNameBottomSheet(
                context: context,
                headerTitle: AppStringResources.adminName,
                fieldHint: AppStringResources.adminName,
                options: DefaultNames.adminNames,
                nameType: NameType.admin,
              );
            },
          ),
          const SizedBox(height: 8),
          _PersonalizationButton(
            text: AppStringResources.eventName,
            value: provider.eventName,
            onPressed: () {
              showChangeNameBottomSheet(
                context: context,
                headerTitle: AppStringResources.eventName,
                fieldHint: AppStringResources.eventName,
                options: DefaultNames.eventNames,
                nameType: NameType.event,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PersonalizationButton extends StatelessWidget {
  final String text;
  final String value;
  final void Function()? onPressed;

  const _PersonalizationButton({
    required this.text,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      minHeight: 56,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      background: Colors.white,
      child: Row(
        children: <Widget>[
          _buttonText(),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerRight,
            child: const IntrinsicWidth(
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 24,
                color: Color(0xFF8C8C8C),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: AppTextStyles.mainTextStyle,
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: AppTextStyles.hintTextStyle,
          ),
        ],
      ),
    );
  }
}
