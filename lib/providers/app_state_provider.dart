import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppState {
  String? selectedBank;
  bool isTerminalActivated;
  bool isAuth;

  AppState({
    this.selectedBank = null,
    this.isTerminalActivated = false,
    this.isAuth = false,
  });
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void updateSelectedBank(String selectedBank) {
    state = AppState(
      selectedBank: selectedBank,
      isTerminalActivated: state.isTerminalActivated,
      isAuth: state.isAuth,
    );
  }

  void updateIsTerminalActivated(bool isTerminalActivated) {
    state = AppState(
      selectedBank: state.selectedBank,
      isTerminalActivated: isTerminalActivated,
      isAuth: state.isAuth,
    );
  }

  void updateIsAuth(bool isAuth) {
    state = AppState(
      selectedBank: state.selectedBank,
      isTerminalActivated: state.isTerminalActivated,
      isAuth: isAuth,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) => AppStateNotifier());