import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/auth/auth_controller.dart';
import 'package:real_estate_app/auth/client_home_screen.dart';
import 'package:real_estate_app/providers.dart';

import '../role/role_provider.dart';
import 'merchant_home_screen.dart';

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
                        onSuccess: redirect,
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

  redirect() {
    // final currentUserRole = await getCurrentUser();
    final currentUserRole = ref.read(currentUserProvider).value;
    final roles = ref.read(roleListProvider).requireValue;
    for (var role in roles) {
      if (role.id == currentUserRole) {
        if (role.name == 'Merchant') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MerchantHomeScreen(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ClientHomeScreen(),
            ),
          );
        }
      }
    }
  }
}
