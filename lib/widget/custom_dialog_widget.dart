import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:go_router/go_router.dart';

import '../style/app_color.dart';

class CustomDialogWidget {
  CustomDialogWidget._();

  static void showCustomDialog({
    required BuildContext context,
    Widget? icon,
    String? title,
    String? description,
    String? confirmationText,
    Function()? confirmationFun,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: Durations.medium4,
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          icon: icon,
          clipBehavior: Clip.antiAlias,
          backgroundColor: context.isDarkModeOn
              ? AppColor.darkScaffold
              : AppColor.ligthScaffold,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              if (description != null)
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColor.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          backgroundColor: context.isDarkModeOn
                              ? AppColor.darkScaffold
                              : AppColor.ligthScaffold,
                          foregroundColor: context.isDarkModeOn
                              ? AppColor.white
                              : AppColor.black,
                        ),
                        onPressed: () => context.pop(),
                        child: Text(
                          context.loc.close,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    VerticalDivider(color: AppColor.grey, width: 1),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          backgroundColor: context.isDarkModeOn
                              ? AppColor.darkScaffold
                              : AppColor.ligthScaffold,
                          foregroundColor: context.isDarkModeOn
                              ? AppColor.white
                              : AppColor.black,
                        ),
                        onPressed: () {
                          context.pop();
                          confirmationFun?.call();
                        },
                        child: Text(
                          confirmationText ?? context.loc.confirm,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> slideTween =
            Tween(begin: const Offset(0, 1), end: Offset.zero);

        Animation<double> fadeAnimation =
            Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.55, 1, curve: Curves.easeIn),
          ),
        );

        return SlideTransition(
          position: slideTween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
