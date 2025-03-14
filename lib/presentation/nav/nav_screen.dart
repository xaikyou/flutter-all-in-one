import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        height: kBottomNavigationBarHeight,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: [
          NavigationDestination(
            icon: Icon(MingCute.home_4_line),
            selectedIcon: Icon(
              MingCute.home_4_line,
              color: AppColor.selectedNavIcon,
            ),
            label: context.loc.home,
            tooltip: '',
          ),
          NavigationDestination(
            icon: Icon(MingCute.history_anticlockwise_line),
            selectedIcon: Icon(
              MingCute.history_anticlockwise_line,
              color: AppColor.selectedNavIcon,
            ),
            label: context.loc.history,
            tooltip: '',
          ),
          NavigationDestination(
            icon: Icon(MingCute.star_line),
            selectedIcon: Icon(
              MingCute.star_line,
              color: AppColor.selectedNavIcon,
            ),
            label: context.loc.favorite,
            tooltip: '',
          ),
          NavigationDestination(
            icon: Icon(MingCute.user_2_line),
            selectedIcon: Icon(
              MingCute.user_2_line,
              color: AppColor.selectedNavIcon,
            ),
            label: context.loc.profile,
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
