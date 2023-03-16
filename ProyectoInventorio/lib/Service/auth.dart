import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invetariopersonal/pages/home.dart';
import 'package:invetariopersonal/main.dart';
import 'package:invetariopersonal/rigester/Signin.dart';

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
    print("User id is:");
  } catch (error) {
    print(error);
  }
}

funcsignout() async {
  try {
    var auth = FirebaseAuth.instance;
    await auth.signOut();
    print("User isbsign out:");
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

createAccount({required String email, required String password}) async {
  try {
    var auth = FirebaseAuth.instance;
    var user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    SnackBar(
      content: Text("Usuario creado con email" + email),
    );
    Get.to(home());
    print(user.user?.uid);
  } catch (error) {
    const SnackBar(
      content: Text("Error al crear usuario"),
    );
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

signinWithEmail({required String email, required String password}) async {
  try {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (user.user?.uid != null) {
      Get.to(() => home());
      const SnackBar(
        content: Text("Inicio de sesion exitoso"),
      );
    }
  } on FirebaseAuthException catch (e) {
    SnackBar(
      backgroundColor: Colors.amber,
      content: Text(e.code),
    );
  }
}

founsSignout() async {
  try {
    var auth = FirebaseAuth.instance;
    var user = auth.signOut();
    prefs?.clear();
    Get.offAll(() => const signin());
    print('User is Sign out');
  } catch (error) {
    print(error);
  }
}

updateEmaile({required String? newEmail}) async {
  try {
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser?.updateEmail(newEmail!);
    print('update email');
  } catch (error) {
    print(error);
  }
}
