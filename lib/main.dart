import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/auth/create_account_screen.dart';
import 'package:real_estate_app/auth/login_screen.dart';
import 'package:real_estate_app/auth/merchant_home_screen.dart';
import 'package:real_estate_app/loggers.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(
      const ProviderScope(
        child: MainApp(),
      ),
    );
  }, (e, st) => logErr(e, st));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MerchantHomeScreen(),
        ),
      ),
    );
  }
}
