import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/api_client.dart';
import 'package:real_estate_app/auth/auth_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiClientProvider));
});

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(AuthController.new);

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  createAccount({
    required String name,
    required String email,
    required String role,
    required String phone,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.createAccount(
        role: role,
        phone: phone,
        name: name,
        email: email,
        password: password,
      ),
    );
    onSuccess();
  }

  login({
    required String email,
    required String password,
    VoidCallback? onSuccess,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await authRepository.login(
        password: password,
        email: email,
      );
    });
    onSuccess?.call();
  }
}
