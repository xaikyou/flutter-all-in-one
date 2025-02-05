import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../style/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.getBlackWhite(context),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              ///
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.wifi_rounded,
                  size: 30,
                  color: AppColor.getBlackWhite(context, reverse: true),
                ),
                title: Text(
                  'Connectivity Plus',
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.keyboard_arrow_right_rounded),
              ),
              Divider(),

              ///
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.settings_remote_rounded,
                  size: 30,
                  color: AppColor.getBlackWhite(context, reverse: true),
                ),
                title: Text(
                  'Firebase Remote Config',
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () => context.push(AppRouter.firebaseRemoteConfig),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
