import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/data/const_data.dart';
import 'package:mia_pos_v1/models/bank_option.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';
import 'package:mia_pos_v1/providers/secure_storage_provider.dart';
import 'package:mia_pos_v1/terminal_flow/active_terminal_screen.dart';
import 'package:mia_pos_v1/screens/loading_screen.dart';
import 'package:mia_pos_v1/screens/login_screen.dart';
import 'package:mia_pos_v1/screens/select_bank_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    final secureStorage = ref.read(secureStorageProvider);
    final appStateProviderNotifier = ref.read(appStateProvider.notifier);

    String? terminalActivationId =
        await secureStorage.read(key: 'terminalActivationId');
    String? selectedBankId = await secureStorage.read(key: 'selectedBankId');
    String? appState = await secureStorage.read(key: 'appState');
    String? accessToken = await secureStorage.read(key: 'accessToken');
    String? refreshToken = await secureStorage.read(key: 'refreshToken');
    String? expireDateString = await secureStorage.read(key: 'expireTime');

    DateTime? expireDate =
        expireDateString == null ? null : DateTime.parse(expireDateString);

    BankOption? currentBank = selectedBankId == null
        ? null
        : availableBanks.where((element) => element.id == selectedBankId).first;

    CurrentState currentState = appState == null
        ? CurrentState.activation
        : CurrentState.values
            .where((element) => element.toString() == appState)
            .first;

    appStateProviderNotifier.updateTerminalActivationId(terminalActivationId);
    appStateProviderNotifier.updateSelectedBank(currentBank);
    appStateProviderNotifier.updateTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expireTime: expireDate,
      appState: currentState,
    );

    print(currentState);
    print(terminalActivationId);
    print(accessToken);
    print(refreshToken);
    print(expireDateString);
  }

  @override
  Widget build(BuildContext context) {
    AppState mainAppState = ref.watch(appStateProvider);
    print("MAIN BUILD!!!!, current state : ${mainAppState.appState}");

    switch (mainAppState.appState) {
      case CurrentState.loading:
        return const LoadingScreen();
      case CurrentState.login:
        return LoginScreen(
          terminalActivationId: mainAppState.terminalActivationId!,
        );
      case CurrentState.authethicated:
        return ActiveTerminalScreen();
      default:
        return const SelectBankScreen();
    }
  }
}
