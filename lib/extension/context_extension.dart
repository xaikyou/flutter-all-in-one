import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);

  bool get isDarkModeOn => Theme.of(this).brightness == Brightness.dark;
}
