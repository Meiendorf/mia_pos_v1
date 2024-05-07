import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/models/bank_option.dart';

enum CurrentState { activation, login, authethicated, loading, error }

class AppState {
  BankOption? selectedBank;
  CurrentState appState;

  AppState({
    this.selectedBank,
    this.appState = CurrentState.activation,
  });
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void updateSelectedBank(BankOption selectedBank) {
    state = AppState(
      selectedBank: selectedBank,
      appState: state.appState,
    );
  }

  void updateAppState(CurrentState appState) {
    state = AppState(
      selectedBank: state.selectedBank,
      appState: appState,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
    (ref) => AppStateNotifier());
