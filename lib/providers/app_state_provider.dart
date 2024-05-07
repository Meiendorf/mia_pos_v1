import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CurrentState { activation, login, authethicated, loading, error }

class AppState {
  String? selectedBank;
  CurrentState appState;

  AppState({
    this.selectedBank,
    this.appState = CurrentState.activation,
  });
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void updateSelectedBank(String selectedBank) {
    state = AppState(
      selectedBank: selectedBank,
      appState: state.appState,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>(
    (ref) => AppStateNotifier());
