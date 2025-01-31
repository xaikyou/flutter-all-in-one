import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/app_config/app_config_cubit.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:flutter_all_in_one/style/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.isDarkModeOn ? AppColor.white : AppColor.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Iconsax.translate_outline),
                  title: Text(
                    context.loc.language,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Iconsax.moon_outline),
                  title: Text(
                    context.loc.dark_mode,
                  ),
                  trailing: BlocBuilder<AppConfigCubit, AppConfigState>(
                    builder: (context, state) {
                      final isDarkModeOn =
                          state.themeData == AppTheme.darkTheme;
                      return Switch(
                        value: isDarkModeOn,
                        onChanged: (value) {
                          context.read<AppConfigCubit>().updateTheme(value);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
