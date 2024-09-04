import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/api_client.dart';
import 'package:real_estate_app/models/role_model.dart';
import 'package:real_estate_app/role/role_repository.dart';

final roleListProvider = AsyncNotifierProvider<RoleController, List<RoleModel>>(RoleController.new);

class RoleController extends AsyncNotifier<List<RoleModel>> {
  @override
  FutureOr<List<RoleModel>> build() async {
    final roleRepository = RoleRepository(ApiClient());
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await roleRepository.getRoleList();
      return res.where((role) => role.name != 'Administrator').toList();
    });
    return state.requireValue;
  }
}
