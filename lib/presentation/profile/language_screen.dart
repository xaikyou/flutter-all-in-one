import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/app_config/app_config_cubit.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/l10n/generated/app_localizations.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget flag(String languageCode) {
      switch (languageCode) {
        case 'en':
          return Flag(Flags.united_kingdom);
        case 'vi':
          return Flag(Flags.vietnam);
        default:
          return const SizedBox.shrink();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.isDarkModeOn ? AppColor.black : AppColor.white,
        title: Text(
          context.loc.language,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.isDarkModeOn ? AppColor.black : AppColor.white,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: AppLocalizations.supportedLocales.length,
          itemBuilder: (context, index) {
            final locale = AppLocalizations.supportedLocales[index];
            final languageCode = locale.languageCode;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: flag(languageCode),
              title: Text(
                context
                    .read<AppConfigCubit>()
                    .languageCodeToCountryName(languageCode),
                style: TextStyle(fontSize: 14),
              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
              onTap: () => context.read<AppConfigCubit>().updateLocale(locale),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
