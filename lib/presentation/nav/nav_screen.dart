import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/presentation/nav/cubit/nav_cubit.dart';
import 'package:flutter_all_in_one/style/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            onDestinationSelected: (value) =>
                context.read<NavCubit>().update(value),
            selectedIndex: state.data.navIndex,
            destinations: [
              NavigationDestination(
                icon: Icon(MingCute.home_4_line),
                selectedIcon: Icon(
                  MingCute.home_4_line,
                  color: AppColor.selectedNavIcon,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(MingCute.history_anticlockwise_line),
                selectedIcon: Icon(
                  MingCute.history_anticlockwise_line,
                  color: AppColor.selectedNavIcon,
                ),
                label: 'History',
              ),
              NavigationDestination(
                icon: Icon(MingCute.star_line),
                selectedIcon: Icon(
                  MingCute.star_line,
                  color: AppColor.selectedNavIcon,
                ),
                label: 'Favorite',
              ),
              NavigationDestination(
                icon: Icon(MingCute.user_2_line),
                selectedIcon: Icon(
                  MingCute.user_2_line,
                  color: AppColor.selectedNavIcon,
                ),
                label: 'Profile',
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
