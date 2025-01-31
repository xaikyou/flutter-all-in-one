import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/app_config/app_config_cubit.dart';
import 'package:flutter_all_in_one/l10n/generated/app_localizations.dart';
import 'package:flutter_all_in_one/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppConfigCubit>(
          create: (BuildContext context) => AppConfigCubit(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigCubit, AppConfigState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: "Flutter All In One",
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.locale,
          theme: state.themeData,
        );
      },
    );
  }
}
