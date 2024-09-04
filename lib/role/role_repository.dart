import 'package:real_estate_app/api_client.dart';
import 'package:real_estate_app/models/role_model.dart';

import '../constants.dart';
import '../loggers.dart';

class RoleRepository {
  final ApiClient _client;
  RoleRepository(ApiClient client) : _client = client;

  Future<List<RoleModel>> getRoleList() async {
    try {
      final res = await _client.instance.get(Constants.getRoles);
      logInfo('RESULT OF GETTING ROLES : ${res.data}');
      final roleList = (res.data['data'] as List).map((e) => RoleModel.fromMap(e)).toList();
      logInfo('ROLE LIST: $roleList');
      return roleList;
    } catch (e) {
      logErr(e);
      rethrow;
    }
  }
}
