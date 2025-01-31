import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocalizationBloc extends Cubit<LocalizationState> {
  static const Locale defaultLocale = Locale('en');

  LocalizationBloc() : super(LocalizationState(defaultLocale));

  void updateLocale(Locale locale) {
    emit(LocalizationState(locale));
  }
}

class LocalizationState {
  final Locale? locale;

  LocalizationState(this.locale);
}
