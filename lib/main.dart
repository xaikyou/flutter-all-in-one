import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_config/app_config_cubit.dart';
import 'bloc/connectivity/connectivity_bloc.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'router/app_router.dart';
import 'service/injection/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppConfigCubit>(
          create: (BuildContext context) => AppConfigCubit()..init(),
        ),
        BlocProvider<ConnectivityBloc>(
          create: (BuildContext context) => ConnectivityBloc()
            ..add(WatchConnectivityEvent())
            ..add(CheckConnectivityEvent()),
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
          locale: state.data.locale,
          theme: state.data.themeData,
        );
      },
    );
  }
}
