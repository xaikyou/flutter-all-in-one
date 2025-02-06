part of 'remote_config_bloc.dart';

@freezed
class RemoteConfigStateData with _$RemoteConfigStateData {
  const factory RemoteConfigStateData({
    dynamic value,
    Set<String>? updatedKeys,
  }) = _RemoteConfigStateData;
}

@freezed
class RemoteConfigState with _$RemoteConfigState {
  const factory RemoteConfigState.initial(
    RemoteConfigStateData data,
  ) = _Initial;
  const factory RemoteConfigState.fetchDataLoading(
    RemoteConfigStateData data,
  ) = FetchDataLoading;
  const factory RemoteConfigState.fetchDataSuccess(
    RemoteConfigStateData data,
  ) = FetchDataSuccess;
}
