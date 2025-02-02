import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import '../../service/injection/injection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RemoteConfigService remoteConfig = getIt<RemoteConfigService>();
    return Scaffold(
      body: StreamBuilder<Map<RemoteConfigKey, dynamic>>(
        stream: remoteConfig.remoteConfigStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No remote config data available"));
          }
          final config = snapshot.data!;
          return Center(
            child: Text(config[RemoteConfigKey.text] ?? 'Default Text'),
          );
        },
      ),
    );
  }
}
