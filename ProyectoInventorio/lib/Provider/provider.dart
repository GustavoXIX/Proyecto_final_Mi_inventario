import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/pertenecia.dart';

class CRUDOperationProvider extends ChangeNotifier {
  late List<Pertenencia?> listaPertenencias = [];
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController costeController = TextEditingController();
  TextEditingController imagenController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool isLoading = false;

  // FUNCION PARA AÑADIR PERTENENCIA
  Future<void> sendPertenenciaOnFirebase(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    final url = Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/Usuarios/$userID/Pertenencias.json');

    final response = await http.post(
      url,
      body: jsonEncode({
        "nombre": nombreController.text,
        "descripcion": descripcionController.text,
        "fecha": fechaController.text,
        "coste": costeController.text,
        "imagen": imagenController.text,
      }),
    );

    if (response.statusCode == 200) {
      nombreController.clear();
      descripcionController.clear();
      costeController.clear();
      fechaController.clear();
      imagenController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pertenencia añadida correctamente',
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error al añadir Pertenencia',
        ),
        backgroundColor: Color.fromARGB(255, 247, 62, 49),
      ));
    }

    isLoading = false;
    notifyListeners();
  }

  // FUNCION PARA ACTUALIZAR PERTENENCIA
  Future<void> updatePertenencia({
    required BuildContext context,
    required String id,
  }) async {
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    final url = Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/Usuarios/$userID/Pertenencias/$id.json');

    final response = await http.patch(
      url,
      body: jsonEncode({
        "nombre": nombreController.text,
        "descripcion": descripcionController.text,
        "fecha": fechaController.text,
        "coste": costeController.text,
        "imagen": imagenController.text,
      }),
    );

    if (response.statusCode == 200) {
      nombreController.clear();
      descripcionController.clear();
      costeController.clear();
      fechaController.clear();
      imagenController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pertenencia actualizada correctamente',
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error al actualizar la Pertenencia',
        ),
        backgroundColor: Colors.red,
      ));
    }
    fetchPertenencias();
  }

  // FUNCION PARA OBTENER LAS PERTENENCIAS
  Future<void> fetchPertenencias() async {
    listaPertenencias = [];
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    final url = Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/Usuarios/$userID/Pertenencias.json');
    final response = await http.get(url);
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;

    final pertenenciasData = extractedData as Map<String, dynamic>;

    pertenenciasData.forEach((id, pertenencia) {
      if (pertenencia != null && pertenencia is Map<String, dynamic>) {
        listaPertenencias.add(Pertenencia(
          coste: pertenencia["coste"] ?? "",
          descripcion: pertenencia["descripcion"] ?? "",
          fecha: pertenencia["fecha"] ?? "",
          nombre: pertenencia["nombre"],
          imagen: pertenencia["imagen"] ?? "",
          docId: id,
        ));
      }
    });

    notifyListeners();
  }

  // FUNCION PARA ELIMINAR UNA PERTENENCIA
  Future<void> deletePertenencia({
    required BuildContext context,
    required String id,
  }) async {
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    final url = Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/Usuarios/$userID/Pertenencias/$id.json');

    final response = await http.delete(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pertenencia eliminada correctamente',
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error al eliminar la Pertenencia',
        ),
        backgroundColor: Colors.red,
      ));
    }
    fetchPertenencias();
  }
}
