import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/remote_config/remote_config_bloc.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../style/app_color.dart';

class FirebaseRemoteConfigScreen extends StatefulWidget {
  const FirebaseRemoteConfigScreen({super.key});

  @override
  State<FirebaseRemoteConfigScreen> createState() =>
      _FirebaseRemoteConfigScreenState();
}

class _FirebaseRemoteConfigScreenState
    extends State<FirebaseRemoteConfigScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RemoteConfigBloc>().add(FetchDataEvent(RemoteConfigKey.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoteConfigBloc, RemoteConfigState>(
      listener: (context, state) {
        if (state is FetchDataLoading) {
          context
              .read<RemoteConfigBloc>()
              .add(FetchDataEvent(RemoteConfigKey.text));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.getBlackWhite(context),
          title: Text(
            'Firebase Remote Config',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () {
                  context
                      .read<RemoteConfigBloc>()
                      .add(FetchDataEvent(RemoteConfigKey.text));
                },
                icon: Icon(Icons.refresh_rounded),
              ),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.getBlackWhite(context),
          ),
          child: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
            builder: (context, state) {
              return Text(state.data.value ?? '');
            },
          ),
        ),
      ),
    );
  }
}
