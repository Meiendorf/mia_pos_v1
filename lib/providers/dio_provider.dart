import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final appState = ref.watch(appStateProvider);
  final dio = Dio();

  // Configure Dio based on appState
  dio.options.baseUrl =
      appState.selectedBank == null ? "" : appState.selectedBank!.apiBaseUrl;

  return dio;
});
