import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/router/app_router.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => context.go(AppRouter.nav),
          style: FilledButton.styleFrom(
            backgroundColor: AppColor.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            context.loc.log_in,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
