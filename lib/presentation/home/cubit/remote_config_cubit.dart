import 'package:bloc/bloc.dart';
import 'package:flutter_all_in_one/service/injection/injection.dart';
import 'package:flutter_all_in_one/service/remote_config/remote_config_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_cubit.freezed.dart';
part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final RemoteConfigService _remoteConfigService;
  RemoteConfigCubit()
      : _remoteConfigService = getIt<RemoteConfigService>(),
        super(_Initial(RemoteConfigStateData()));

  Future<void> getValue(RemoteConfigKey key) async {
    emit(FetchDataLoading(state.data));
    await _remoteConfigService.updateValue();
    final value = _remoteConfigService.getValue(key);
    emit(FetchDataSuccess(state.data.copyWith(value: value)));
  }
}
