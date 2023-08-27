import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invetariopersonal/Imports/import.dart';
import 'package:invetariopersonal/Pages/ListaPertenencias.dart';
import 'package:invetariopersonal/main.dart';
import 'package:invetariopersonal/Pages/IniciarSesion.dart';
import 'package:http/http.dart' as http;

late String? userIDtemp = '';

anonymously() async {
  try {
    var auth = FirebaseAuth.instance;
    var users = await auth.signInAnonymously();
    print('users is:');
    print(users.user!.uid.toString());
  } catch (error) {
    print(error);
  }
}

checkuser() async {
  try {
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser?.uid;
    userIDtemp = user;
    print("User id is:" + '$user');
  } catch (error) {
    print(error);
  }
}

funcsignout() async {
  try {
    var auth = FirebaseAuth.instance;
    await auth.signOut();
    print("User is sign out:");
  } catch (error) {
    print(error);
  }
}

Statechange() async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

createAccount(
    {required String email,
    required String password,
    required BuildContext c}) async {
  try {
    var auth = FirebaseAuth.instance;
    var user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    checkuser();
    crearInstanciaUsuario(userIDtemp, c);
    ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      content: Text("Usuario creado con el correo electrónico: $email"),
    ));
    Get.to(() => home());
    print(user.user?.uid);
  } catch (error) {
    String errorMessage;
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          errorMessage = 'La contraseña proporcionada es demasiado débil.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Ya existe una cuenta con ese correo electrónico.';
          break;
        case 'invalid-email':
          errorMessage = 'La dirección de correo electrónico no es válida.';
          break;
        default:
          errorMessage = 'Se produjo un error al crear la cuenta.';
          break;
      }
    } else {
      errorMessage = 'Se produjo un error al crear la cuenta.';
    }

    ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      content: Text(errorMessage),
    ));
  }
}

getEmail() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      print(user.uid);
    }
  });
  ;
}

signinWithEmail(
    {required String email,
    required String password,
    required BuildContext c}) async {
  try {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (user.user?.uid != null) {
      Get.to(() => home());
      checkuser();
      ScaffoldMessenger.of(c).showSnackBar(const SnackBar(
        content: Text("Inicio de sesión exitoso"),
      ));
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;

    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No se encontró un usuario con este correo electrónico.';
        break;
      case 'wrong-password':
        errorMessage = 'Contraseña incorrecta.';
        break;
      case 'invalid-email':
        errorMessage = 'Correo electrónico inválido.';
        break;
      case 'user-disabled':
        errorMessage = 'Este usuario ha sido deshabilitado.';
        break;
      default:
        errorMessage = 'Error de inicio de sesión: ${e.code}';
    }

    ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      content: Text(errorMessage),
    ));
  }
}

founsSignout() async {
  try {
    prefs?.clear();
    Get.offAll(() => const signin());
    print('User is Sign out');
  } catch (error) {
    print(error);
  }
}

updateEmaile({required String? newEmail}) async {
  try {
    print('update email');
  } catch (error) {
    print(error);
  }
}

Future<void> crearInstanciaUsuario(String? userID, BuildContext context) async {
  final url = Uri.parse(
      'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/Usuarios.json');

  final response = await http.post(
    url,
    body: jsonEncode({
      userID: {"Pertenencias": {}}
    }),
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Instancia de usuario creada correctamente',
      ),
      backgroundColor: Colors.green,
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Error al crear la instancia de usuario',
      ),
      backgroundColor: Colors.red,
    ));
  }
}
