import 'Imports/import.dart';
import 'Pages/IniciarSesion.dart';
import 'Theme/Theme.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  Setup();
  Start().onInit();

  runApp(const MyApp());
}

void Setup() async {
  await Future.delayed(const Duration(seconds: 1));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final prefs = snapshot.data;
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
            //DESCOMENTAR CUANDO TERMINE DE LISTAPERTENENCIA
             home: uid == null ?  signin() : home(),
            // home: home(),
          ),
        );
      },
    );
  }
}
