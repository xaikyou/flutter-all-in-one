import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/remote_config/remote_config_bloc.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_config/app_config_cubit.dart';
import 'bloc/connectivity/connectivity_bloc.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'router/app_router.dart';
import 'service/injection/injection.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await configureDependencies();

    /// Firebase Crashlytics
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

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
          BlocProvider<RemoteConfigBloc>(
            create: (BuildContext context) =>
                RemoteConfigBloc()..add(WatchUpdatedKeysEvent()),
          ),
        ],
        child: const MainApp(),
      ),
    );
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocListener<RemoteConfigBloc, RemoteConfigState>(
        listener: (context, state) {
          if (state is FetchDataLoading) {
            if (state.data.updatedKeys
                    ?.contains(RemoteConfigKey.version.name) ??
                false) {
              context.read<AppConfigCubit>().checkForUpdate();
            }
          }
        },
        child: BlocBuilder<AppConfigCubit, AppConfigState>(
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
        ),
      );
    });
  }
}
