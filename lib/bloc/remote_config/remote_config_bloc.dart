import 'package:bloc/bloc.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../service/injection/injection.dart';

part 'remote_config_bloc.freezed.dart';
part 'remote_config_event.dart';
part 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final RemoteConfigService _remoteConfigService;

  RemoteConfigBloc()
      : _remoteConfigService = getIt<RemoteConfigService>(),
        super(_Initial(RemoteConfigStateData())) {
    on<WatchUpdatedKeysEvent>((event, emit) async {
      await checkUpdatedKeys(emit);
    });
    on<FetchDataEvent>((event, emit) async {
      await fetchData(emit, event.key);
    });
  }

  Future<void> fetchData(
      Emitter<RemoteConfigState> emit, RemoteConfigKey key) async {
    emit(FetchDataLoading(state.data));
    await _remoteConfigService.updateValue();
    final value = _remoteConfigService.getValue(key);
    emit(FetchDataSuccess(state.data.copyWith(value: value)));
  }

  Future<void> checkUpdatedKeys(Emitter<RemoteConfigState> emit) async {
    await emit.forEach(_remoteConfigService.remoteConfigStream,
        onData: (value) {
      return FetchDataLoading(state.data);
    });
  }
}
