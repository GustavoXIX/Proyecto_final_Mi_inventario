import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Service/Service.dart';
import 'package:invetariopersonal/Service/locale.dart';
import 'package:invetariopersonal/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Temas/Theme.dart';
import 'rigester/Signin.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  Start().onInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CRUDOperationProvider()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: Languages(),
          locale: Get.deviceLocale,
          theme: tema,
          fallbackLocale: const Locale('en', 'US'),
          home: prefs?.get('id') == null ? signin() : home(),
        ));
  }
}
