import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invetariopersonal/Service/auth.dart';
import 'package:invetariopersonal/combonent/CustomButton.dart';
import 'package:invetariopersonal/rigester/Signout.dart';
import 'package:invetariopersonal/rigester/header_widget.dart';

import '../pages/home.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

// final _formkeyemail = GlobalKey<FormState>();
// final _formkeypassword = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();

class _signinState extends State<signin> {
  final double _height = 100;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: _height, child: HeaderWidget(_height)),
                Container(
                  //     padding: EdgeInsets.only(left: 13, right: 13),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Text('Hola'.tr,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 70)),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          height: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  icon: Icon(Icons.mail),
                                  hintText: "ejemplo@correo.com".tr,
                                  labelText: 'Correo electronico',
                                ),
                                onChanged: (value) {},
                              ),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                // formkay: _formkeypassword,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  icon: Icon(Icons.lock),
                                  hintText: "Contraseña".tr,
                                  labelText: 'Contraseña',
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      }),
                                  //  Pssword
                                ),
                              )
                            ],
                          ),
                        ),
                        defultbutton(
                          text: 'Iniciar sesion'.tr,
                          press: () async {
                            await signinWithEmail(
                                email: emailController.text,
                                password: passwordController.text);

                            Statechange();
                          },
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("¿No tienes cuenta?".tr),
                                  TextButton(
                                    onPressed: () async {
                                      setState(() {});
                                      Get.to(Signup());
                                    },
                                    child: Text('registrarse'.tr),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("ca1".tr),
    onPressed: () {
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    child: Text("co1".tr),
    onPressed: () {
      Get.back();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ac1".tr),
    content: Text("an12".tr),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
