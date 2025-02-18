import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/presentation/nav/cubit/nav_cubit.dart';
import 'package:flutter_all_in_one/router/app_router.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavCubit(),
      child: NavBody(),
    );
  }
}

class NavBody extends StatelessWidget {
  const NavBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          return NavigationBar(
            height: kBottomNavigationBarHeight,
            onDestinationSelected: (value) =>
                context.read<NavCubit>().update(value),
            selectedIndex: state.data.navIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
              InkWell(
                splashFactory: NoSplash.splashFactory,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () => context.push(AppRouter.qrScanner),
                child: Ink(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.yellow,
                        child: Icon(
                          MingCute.scan_line,
                          color: AppColor.white,
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 8),
                      //   decoration: ShapeDecoration(
                      //     shape: StadiumBorder(),
                      //     color: AppColor.yellow,
                      //   ),
                      //   child: Text(
                      //     context.loc.scan_qr,
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //       color: AppColor.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
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
          );
        },
      ),
      body: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          return state.data.screens[state.data.navIndex];
        },
      ),
    );
  }
}
