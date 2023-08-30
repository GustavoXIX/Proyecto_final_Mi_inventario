import 'package:invetariopersonal/Imports/import.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 196, 189, 255),
  secondaryHeaderColor: const Color.fromARGB(255, 1, 215, 243),
  scaffoldBackgroundColor: const Color.fromARGB(255, 242, 243, 244),
  cardColor: const Color.fromARGB(255, 219, 219, 219),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor:
        Color.fromARGB(255, 211, 211, 211), // Define el fillColor deseado
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 70, color: Colors.black87),
    labelSmall: TextStyle(
      fontSize: 15,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.black87,
    contentTextStyle: TextStyle(
      color: Colors
          .grey[300], // Define el color deseado para el texto del SnackBar
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 29, 6, 238),
  secondaryHeaderColor: const Color.fromARGB(255, 1, 215, 243),
  scaffoldBackgroundColor: const Color.fromARGB(255, 16, 12, 8),
  cardColor: const Color.fromARGB(255, 76, 76, 76),
  textTheme: const TextTheme(
    titleLarge:
        TextStyle(color: Color.fromARGB(221, 255, 255, 255), fontSize: 70),
    labelSmall: TextStyle(
      fontSize: 15,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[300],
    contentTextStyle: const TextStyle(
      color:
          Colors.black87, // Define el color deseado para el texto del SnackBar
    ),
  ),
);