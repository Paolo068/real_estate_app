import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/auth/auth_controller.dart';
import 'package:real_estate_app/models/role_model.dart';

import '../providers.dart';
import '../role/role_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String role = '';

  final emailCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final roleList = ref.watch(roleListProvider).value;
   final currentUser = ref.watch(currentUserProvider);
   roleList!.where((r)=>r.name)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).login(
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
