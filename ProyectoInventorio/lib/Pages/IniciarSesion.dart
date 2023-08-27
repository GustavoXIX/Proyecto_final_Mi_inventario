// ignore_for_file: use_build_context_synchronously

import 'Registrarse.dart';
import 'package:invetariopersonal/Imports/import.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
List<Pertenencia> listaPertenencias = [];

class _signinState extends State<signin> {
  final double _height = 100;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                       const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Text(
                            'Hola',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 70.0),
                          ),
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
                          text: 'Iniciar sesion',
                          press: () async {                            
                            await signinWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                              c: context,
                            );
                            Statechange();
                            emailController.clear();
                            passwordController.clear();
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
                                      emailController.clear();
                                      passwordController.clear();
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