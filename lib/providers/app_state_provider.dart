import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/models/bank_option.dart';
import 'package:mia_pos_v1/providers/secure_storage_provider.dart';

enum CurrentState { activation, login, authethicated, loading, error }

class AppState {
  BankOption? selectedBank;
  CurrentState appState;
  String? accessToken;
  String? refreshToken;
  DateTime? expireTime;

  AppState({
    this.selectedBank,
    this.appState = CurrentState.loading,
    this.accessToken,
    this.refreshToken,
    this.expireTime,
  });
}

class AppStateNotifier extends StateNotifier<AppState> {
  final StateNotifierProviderRef<AppStateNotifier, AppState> ref;

  AppStateNotifier(this.ref) : super(AppState());

  void updateSelectedBank(BankOption? selectedBank) {
    state = AppState(
      selectedBank: selectedBank,
      appState: state.appState,
      accessToken: state.accessToken,
      refreshToken: state.refreshToken,
      expireTime: state.expireTime,
    );
  }

  void updateAppState(CurrentState appState) {
    state = AppState(
      selectedBank: state.selectedBank,
      appState: appState,
      accessToken: state.accessToken,
      refreshToken: state.refreshToken,
      expireTime: state.expireTime,
    );
  }

  void updateTokens({
    required String? accessToken,
    required String? refreshToken,
    required DateTime? expireTime,
    required CurrentState appState,
  }) async {
    state = AppState(
      selectedBank: state.selectedBank,
      appState: appState,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expireTime: expireTime,
    );

    final secureStorage = ref.read(secureStorageProvider);
    secureStorage.write(
      key: "accessToken",
      value: accessToken,
    );
    secureStorage.write(
      key: "refreshToken",
      value: refreshToken,
    );
    secureStorage.write(
      key: "expireTime",
      value: expireTime?.toIso8601String(),
    );
    secureStorage.write(
      key: "appState",
      value: CurrentState.authethicated.toString(),
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
    (ref) => AppStateNotifier(ref));
