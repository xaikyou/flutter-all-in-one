import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/app_config/app_config_cubit.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/router/app_router.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:flutter_all_in_one/style/app_theme.dart';
import 'package:flutter_all_in_one/widget/custom_dialog_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            const SizedBox.shrink(),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 40,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    // border: Border.all(color: AppColor.yellow),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.getBlackWhite(context),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Xaikyou',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '0123-456-789',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: AppColor.yellow,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColor.getBlackWhite(context),
                      backgroundImage: Image.asset(
                        'asset/shiba.png',
                        isAntiAlias: true,
                      ).image,
                    ),
                  ),
                ),
              ],
            ),

            /// Settings
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.getBlackWhite(context),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Language
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Iconsax.translate_outline),
                    title: Text(
                      context.loc.language,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () => context.push(AppRouter.language),
                  ),
                  Divider(),

                  /// Dark Mode
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Iconsax.moon_outline),
                    title: Text(
                      context.loc.dark_mode,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: BlocBuilder<AppConfigCubit, AppConfigState>(
                      builder: (context, state) {
                        final isDarkModeOn =
                            state.data.themeData == AppTheme.darkTheme;
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

            /// Logout
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.getBlackWhite(context),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        context.loc.log_out,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    onTap: () => CustomDialogWidget.showCustomDialog(
                      context: context,
                      title: context.loc.log_out,
                      description: context.loc.log_out_description,
                      confirmationText: context.loc.log_out,
                      confirmationFun: () => context.go(AppRouter.splash),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              context.read<AppConfigCubit>().state.data.version ?? '',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
