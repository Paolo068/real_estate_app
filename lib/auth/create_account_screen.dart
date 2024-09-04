import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_app/auth/auth_controller.dart';
import 'package:real_estate_app/auth/loading_screen.dart';

import '../role/role_provider.dart';
import 'login_screen.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  String roleId = '';

  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final asyncRoles = ref.watch(roleListProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Your Account'),
        ),
        body: asyncRoles.isLoading
            ? Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                        child: Center(
                          child: Text('Frosted', style: Theme.of(context).textTheme.displayMedium),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'quis nostrud exercitation ullamco laboris nisi ut',
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: asyncRoles.value?.first.id,
                        items: asyncRoles.value!
                            .map(
                              (r) => DropdownMenuItem<String>(
                                value: r.id,
                                child: Text(r.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {});
                          roleId = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Noms & prenoms',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Telephone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail),
                          )),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: passwordCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authControllerProvider.notifier).createAccount(
                                name: nameCtrl.text,
                                email: emailCtrl.text,
                                role: roleId,
                                phone: phoneCtrl.text,
                                onSuccess: () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                ),
                                password: passwordCtrl.text,
                              );
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
