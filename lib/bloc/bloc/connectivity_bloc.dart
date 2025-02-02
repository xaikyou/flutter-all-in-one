import 'package:bloc/bloc.dart';
import 'package:flutter_all_in_one/service/injection/injection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../service/connectivity/connectivity_service.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';
part 'connectivity_bloc.freezed.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivity;
  ConnectivityBloc()
      : _connectivity = getIt<ConnectivityService>(),
        super(_Initial()) {
    on<WatchConnectivityEvent>((event, emit) async {
      await _changeConnectionStatus(emit);
    });
    on<CheckConnectivityEvent>((event, emit) async {
      await _checkConnectivity(emit);
    });
  }

  Future<void> _changeConnectionStatus(Emitter<ConnectivityState> emit) async {
    await emit.forEach(_connectivity.onConnectivityChange,
        onData: (bool value) {
      if (value == true) {
        return ConnectedState();
      } else {
        return DisconnectedState();
      }
    });
  }

  Future<void> _checkConnectivity(Emitter<ConnectivityState> emit) async {
    bool isConnected = await _connectivity.isConnected;

    if (isConnected) {
      emit(ConnectedState());
    } else {
      emit(DisconnectedState());
    }
  }
}
