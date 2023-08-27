import 'Pages/IniciarSesion.dart';
import 'Imports/import.dart';
import 'Theme/Theme.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  Setup();
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
