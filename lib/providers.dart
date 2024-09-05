import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/api_client.dart';
import 'package:real_estate_app/auth/auth_repository.dart';

final currentUserProvider = FutureProvider<String>((ref) async {
  final authRepos = AuthRepository(ApiClient());
  final currentUser = await authRepos.getCurrentUser();
  return currentUser;
});
