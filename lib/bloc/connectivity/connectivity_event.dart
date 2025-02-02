part of 'connectivity_bloc.dart';

@freezed
class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.watchConnectivityEvent() =
      WatchConnectivityEvent;
  const factory ConnectivityEvent.checkConnectivityEvent() =
      CheckConnectivityEvent;
}
