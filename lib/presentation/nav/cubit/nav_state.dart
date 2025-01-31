part of 'nav_cubit.dart';

@freezed
class NavStateData with _$NavStateData {
  const factory NavStateData({
    @Default(0) int navIndex,
    @Default([]) List<Widget> screens,
  }) = _NavStateData;
}

@freezed
class NavState with _$NavState {
  const factory NavState.initialState(
    NavStateData data,
  ) = _InitialState;
  const factory NavState.updateIndexState(
    NavStateData data,
  ) = UpdateIndexState;
}
