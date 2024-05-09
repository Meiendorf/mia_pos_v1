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
  String? terminalActivationId;

  AppState({
    this.selectedBank,
    this.appState = CurrentState.loading,
    this.accessToken,
    this.refreshToken,
    this.expireTime,
    this.terminalActivationId,
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
      terminalActivationId: state.terminalActivationId,
    );
  }

  void updateTerminalActivationId(String? terminalActivationId) {
    state = AppState(
      selectedBank: state.selectedBank,
      appState: state.appState,
      accessToken: state.accessToken,
      refreshToken: state.refreshToken,
      expireTime: state.expireTime,
      terminalActivationId: terminalActivationId,
    );
  }

  void updateAppState(CurrentState appState) async {
    state = AppState(
      selectedBank: state.selectedBank,
      appState: appState,
      accessToken: state.accessToken,
      refreshToken: state.refreshToken,
      expireTime: state.expireTime,
      terminalActivationId: state.terminalActivationId,
    );
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.write(
      key: "appState",
      value: appState.toString(),
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
      terminalActivationId: state.terminalActivationId,
    );

    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.write(
      key: "accessToken",
      value: accessToken,
    );
    await secureStorage.write(
      key: "refreshToken",
      value: refreshToken,
    );
    await secureStorage.write(
      key: "expireTime",
      value: expireTime?.toIso8601String(),
    );
    await secureStorage.write(
      key: "appState",
      value: appState.toString(),
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
    (ref) => AppStateNotifier(ref));
