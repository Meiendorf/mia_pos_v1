import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/main.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final appState = ref.watch(appStateProvider);
  final dio = Dio();

  // Configure Dio based on appState
  dio.options.baseUrl = appState.selectedBank?.apiBaseUrl ?? "";

  return dio;
});

final authDioProvider = Provider<Dio>((ref) {
  final appState = ref.watch(appStateProvider);
  final unauthDio = ref.read(dioProvider);
  final dio = Dio();

  // Configure Dio based on appState
  dio.options.baseUrl = appState.selectedBank?.apiBaseUrl ?? "";
  String? finalAccessToken = appState.accessToken;

  // Add refresh token and access token interceptors
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Check if the access token is about to expire
      if (appState.expireTime != null &&
          appState.expireTime!.difference(DateTime.now()).inSeconds <= 10) {
        // Refresh token logic
        try {
          final response =
              await unauthDio.post('/pos/api/v1/seller/refresh', data: {
            'refreshToken': appState.refreshToken,
            'terminalActivationId': appState.terminalActivationId,
          });

          if (response.data == null || response.data['result'] != 'success') {
            print(
                'Error while refreshing token in interceptor : ${response.data}');

            ref.read(appStateProvider.notifier).updateTokens(
                  accessToken: null,
                  refreshToken: null,
                  expireTime: null,
                  appState: CurrentState.activation,
                );

            showErrorDialog('Your session has expired.');
            return handler.reject(DioException(
              requestOptions: options,
              error: 'Failed to refresh token',
            ));
          }

          final tokens = response.data['authTokens'];
          int expiresIn = tokens['accessTokenExpiresIn'];
          finalAccessToken = tokens['accessToken'];

          ref.read(appStateProvider.notifier).updateTokens(
                accessToken: tokens['accessToken'],
                refreshToken: tokens['refreshToken'],
                expireTime: DateTime.now().add(Duration(seconds: expiresIn)),
                appState: CurrentState.authethicated,
              );
          // print("Tokens refreshed!");
        } catch (e) {
          // Handle refresh token failure
          ref.read(appStateProvider.notifier).updateTokens(
                accessToken: null,
                refreshToken: null,
                expireTime: null,
                appState: CurrentState.activation,
              );
          showErrorDialog('Your session has expired.');
          return handler.reject(DioException(
            requestOptions: options,
            error: 'Failed to refresh token',
          ));
        }
      }

      // Add Auth header with access token
      options.headers['Authorization'] = 'Bearer $finalAccessToken';
      handler.next(options);
    },
  ));

  return dio;
});

void showErrorDialog(String message) {
  showDialog(
    context: NavigationService.navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: const Text("Error"),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
