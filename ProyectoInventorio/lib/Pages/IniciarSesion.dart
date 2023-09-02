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
  bool saveCredentials = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    cargarUsuario();
    super.initState();
  }

  cargarUsuario() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CRUDOperationProvider>(context);
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
                        const SizedBox(
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          height: 54,
                          child: Row(
                            children: [
                              const SizedBox(width: 15.0),
                              const Icon(
                                Icons.shield_moon_sharp,
                                color: Color.fromARGB(255, 111, 111, 111),
                              ),
                              const SizedBox(width: 55.0), // Icono del candado
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Mantener la sesión iniciada"),
                                  InkWell(
                                    onTap: () {
                                      setState(()  {
                                        saveCredentials = !saveCredentials;
                                        if (saveCredentials) {
                                         prefs!.setBool('check',true);
                                        } else {
                                         prefs!.setBool('check',false);
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 24.0,
                                      height: 24.0,
                                      margin: EdgeInsets.symmetric(horizontal: 32.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: saveCredentials
                                            ? Colors.blue
                                            : Colors.transparent,
                                        border: Border.all(color: Colors.blue),
                                      ),
                                      child: saveCredentials
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16.0,
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
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
                            provider.fetchPertenencias();
                            //Statechange();
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
