import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/presentation/favorite/favorite_screen.dart';
import 'package:flutter_all_in_one/presentation/history/history_screen.dart';
import 'package:flutter_all_in_one/presentation/home/home_screen.dart';
import 'package:flutter_all_in_one/presentation/profile/profile_screen.dart';
import 'package:flutter_all_in_one/presentation/qr_scanner/qr_scanner_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nav_cubit.freezed.dart';
part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  static final _screens = [
    HomeScreen(),
    HistoryScreen(),
    QrScannerScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  NavCubit()
      : super(_InitialState(NavStateData(
          navIndex: 0,
          screens: _screens,
        )));

  void update(int index) {
    emit(UpdateIndexState(state.data.copyWith(navIndex: index)));
  }
}
