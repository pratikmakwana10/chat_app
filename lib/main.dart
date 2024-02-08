import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/authentication/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ThemeController());
  runApp(const MyApp());
}

//void main() {
//   Get.put(ThemeController()); // Initialize ThemeController
//   runApp(MyApp());
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Light/Dark Theme Example',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const AuthGate(),
    );
  }
}
