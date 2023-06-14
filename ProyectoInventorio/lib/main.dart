import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Service/Service.dart';
import 'package:invetariopersonal/Service/locale.dart';
import 'package:invetariopersonal/Pages/ListaPertenencias.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Theme/Theme.dart';
import 'Pages/IniciarSesion.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Setup();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  Start().onInit();

  runApp(const MyApp());
}

void Setup() async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;

    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final prefs = snapshot.data as SharedPreferences?;
        final uid = prefs?.getString('uid');

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => CRUDOperationProvider(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: Languages(),
            locale: Get.deviceLocale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: uid == null ? signin() : home(),
          ),
        );
      },
    );
  }
}
