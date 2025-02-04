// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/bloc/remote_config/remote_config_bloc.dart';
import 'package:flutter_all_in_one/extension/context_extension.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../style/app_color.dart';

class FirebaseRemoteConfigScreen extends StatelessWidget {
  const FirebaseRemoteConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemoteConfigBloc()..add(WatchUpdatedKeysEvent()),
      child: const FirebaseRemoteConfigBody(),
    );
  }
}

class FirebaseRemoteConfigBody extends StatefulWidget {
  const FirebaseRemoteConfigBody({super.key});

  @override
  State<FirebaseRemoteConfigBody> createState() =>
      _FirebaseRemoteConfigBodyState();
}

class _FirebaseRemoteConfigBodyState extends State<FirebaseRemoteConfigBody> {
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
          backgroundColor:
              context.isDarkModeOn ? AppColor.black : AppColor.white,
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
            color: context.isDarkModeOn ? AppColor.black : AppColor.white,
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
