import 'package:flutter/material.dart';
import 'package:maxim/app_string_resources.dart';
import 'package:maxim/app_color_resources.dart';
import 'package:maxim/presentations/account_settings/account_settings_page.dart';
import 'package:maxim/presentations/personalization/personalization_page.dart';
import 'package:maxim/presentations/profile/profile_provider.dart';
import 'package:maxim/widgets/app_button.dart';
import 'package:maxim/widgets/app_shimmer.dart';
import 'package:maxim/widgets/app_text_styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ProfileAppBar(),
      body: ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              _ProfileHeader(),
              _ProfileBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStringResources.profile,
          style: AppTextStyles.appBarTextStyle,
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: IntrinsicWidth(
            child: TextButton(
              onPressed: () {
                //TODO Edit button handler
              },
              child: const Text(
                AppStringResources.edit,
                style: AppTextStyles.editTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: switch (provider.state) {
            PendingState() => _PendingDisplay(),
            DataState() =>
              _ProfileWithDataDisplay(state: provider.state as DataState),
          },
        );
      },
    );
  }
}

class _ProfileWithDataDisplay extends StatelessWidget {
  final DataState state;

  const _ProfileWithDataDisplay({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _ClientIcon(state.username),
        const SizedBox(width: 16),
        _ProfileInfo(username: state.username, phoneNumber: state.phoneNumber),
        const SizedBox(width: 16),
        _Status(state.status),
      ],
    );
  }
}

class _PendingDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AppShimmer(
          child: Container(
            height: 64,
            width: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorResources.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
            width: 190,
            height: 48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppShimmer(
                  child: Container(
                    width: 137,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColorResources.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AppShimmer(
                  child: Container(
                    width: 123,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColorResources.white,
                    ),
                  ),
                ),
              ],
            )),
        const SizedBox(width: 16),
        AppShimmer(
          child: Container(
            width: 57,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColorResources.white,
            ),
          ),
        )
      ],
    );
  }
}

class _ClientIcon extends StatelessWidget {
  final String text;

  const _ClientIcon(this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: text.toColor(),
      borderRadius: BorderRadius.circular(150),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(150)),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(color: _color, fontSize: _fontSize),
            child: Text(
              text.initials(),
            ),
          ),
        ),
      ),
    );
  }

  Color get _color => HSLColor.fromColor(text.toColor()).lightness < 0.8
      ? AppColorResources.white
      : AppColorResources.black87;

  double get _fontSize => 45 / (text.initials().length == 2 ? 2.5 : 1.8);
}

class _ProfileInfo extends StatelessWidget {
  final String username;

  final String phoneNumber;

  const _ProfileInfo({
    required this.username,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            username,
            style: AppTextStyles.boldTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            phoneNumber.toKazakhstanPhoneFormat(),
            style: AppTextStyles.phoneNumberTextStyle,
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  final String status;

  const _Status(this.status);

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      textAlign: TextAlign.end,
      style: AppTextStyles.statusTextStyle,
    );
  }
}

class _ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        children: <Widget>[
          _ProfileButton(
            text: AppStringResources.accountSettings,
            onPressed: () {
              // TODO

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _ProfileButton(
            text: AppStringResources.personalization,
            onPressed: () {
              // TODO тут находится навигация

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalizationPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _ProfileButton(
            text: AppStringResources.freezingAllClient,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          _ProfileButton(
            text: AppStringResources.shareWithFriend,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          _ProfileButton(
            text: AppStringResources.syncWithCalendar,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  final String text;

  final void Function()? onPressed;

  const _ProfileButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      minHeight: 56,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      background: AppColorResources.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: AppTextStyles.mainTextStyle,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerRight,
            child: const IntrinsicWidth(
              child: Icon(
                Icons.chevron_right,
                size: 24,
                color: AppColorResources.lightGray,
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension on String {
  int _hash() {
    int hash = 0;
    for (var code in runes) {
      hash = code + ((hash * 31) + hash);
    }
    return hash;
  }

  Color toColor() {
    int hash = _hash();
    int r = (hash & 0xFF0000) >> 16;
    int g = (hash & 0x00FF00) >> 8;
    int b = hash & 0x0000FF;

    r = (r * 1.5).toInt() + 20;
    g = (g * 1.5).toInt() + 20;
    b = (b * 1.5).toInt() + 20;

    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return Color.fromRGBO(r, g, b, 1.0);
  }

  String initials() {
    String result = "";
    List<String> words = trim().split(" ");
    for (var element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }

    return result.trim().toUpperCase();
  }

  String toKazakhstanPhoneFormat() {
    if (startsWith('+7')) {
      final digitsOnly = replaceFirst('+7', '');
      return _formatAsKazakhstanNumber('+7', digitsOnly);
    } else if (startsWith('8')) {
      final digitsOnly = substring(1);
      return _formatAsKazakhstanNumber('8', digitsOnly);
    }

    return this;
  }

  String _formatAsKazakhstanNumber(String prefix, String digitsOnly) {
    if (digitsOnly.length < 10) {
      return this;
    }

    return '$prefix ${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, 6)} ${digitsOnly.substring(6, 8)} ${digitsOnly.substring(8, 10)}';
  }
}
