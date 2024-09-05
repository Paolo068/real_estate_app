import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_app/auth/auth_controller.dart';
import 'package:real_estate_app/loggers.dart';

import 'login_screen.dart';

class MerchantHomeScreen extends ConsumerStatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  ConsumerState<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends ConsumerState<MerchantHomeScreen> {
  String? roleId = '';

  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Property'),
        ),
        body: SingleChildScrollView(
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
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nom de la propriete',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: 'prix',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    )),
                const SizedBox(height: 16.0),
                FormBuilderFilePicker(
                  name: "images",
                  decoration: const InputDecoration(labelText: "Attachments"),
                  maxFiles: null,
                  previewImages: true,
                  onChanged: (val) => print(val),
                  typeSelectors: const [
                    TypeSelector(
                      type: FileType.image,
                      selector: Row(
                        children: <Widget>[
                          Icon(Icons.add_circle),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("Add image"),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onFileLoading: (val) {
                    logInfo('onFileLoading: $val');
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).createAccount(
                          name: nameCtrl.text,
                          email: emailCtrl.text,
                          role: roleId.toString(),
                          phone: phoneCtrl.text,
                          onSuccess: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          password: passwordCtrl.text,
                        );
                  },
                  child: const Text('Add property'),
                ),
              ],
            ),
          ),
        ));
  }
}
