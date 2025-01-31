import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get scan_qr => 'Scan QR';

  @override
  String get favorite => 'Favorite';

  @override
  String get profile => 'Profile';

  @override
  String get language => 'Language';

  @override
  String get dark_mode => 'Dark mode';

  @override
  String get log_out => 'Log out';

  @override
  String get close => 'Close';

  @override
  String get confirm => 'Confirm';

  @override
  String get log_out_description => 'Are you sure you want to log out?';
}
