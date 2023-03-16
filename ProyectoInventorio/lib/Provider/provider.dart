import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invetariopersonal/modelo/pertenecia.dart';

class CRUDOperationProvider extends ChangeNotifier {
  CRUDOperationProvider() {
    fetchPertenencias();
  }

  late List<Pertenencia?> listaPertencias;
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController costeController = TextEditingController();
  TextEditingController imagenController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool isLoading = false;
  // FUNCION PARA AÑADIR PERTENENCIA
  sendPertenenciaOnFirebase(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse(
          'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/pertenencia.json'),
      body: jsonEncode({
        "nombre": nombreController.text,
        "descripcion": descripcionController.text,
        "fecha": fechaController.text,
        "coste": costeController.text,
        "imagen": imagenController.text,
        "id": idController.text,
      }),
    );

    if (response.statusCode == 200) {
      nombreController = TextEditingController();
      descripcionController = TextEditingController();
      costeController = TextEditingController();
      fechaController = TextEditingController();
      imagenController = TextEditingController();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pertencia añadida correctamente',
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error al añadir Pertencia',
        ),
        backgroundColor: Color.fromARGB(255, 247, 62, 49),
      ));
    }

    isLoading = false;
    notifyListeners();
  }

  //FUNCION PARA ACTUALIZAR PERTENENCIA
  updatePertenencia({required BuildContext context, required String id}) async {
    final response = await http.patch(
        Uri.parse(
            'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/pertenencia/$id.json'),
        body: jsonEncode({
          "nombre": nombreController.text,
          "descripcion": descripcionController.text,
          "fecha": fechaController.text,
          "coste": costeController.text,
          "imagen": imagenController.text,
        }));
    if (response.statusCode == 200) {
      nombreController = TextEditingController();
      descripcionController = TextEditingController();
      costeController = TextEditingController();
      fechaController = TextEditingController();
      imagenController = TextEditingController();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pertencia actualizado correctamente',
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error al actualizar el Pertencia',
        ),
        backgroundColor: Colors.red,
      ));
    }
    fetchPertenencias();
  }

  //FUNCION PARA OBTENER LOS PERTENENCIAS
  fetchPertenencias() async {
    listaPertencias = [];

    final response = await http.get(Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/pertenencia.json'));
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    extractedData.forEach((key, value) {
      if (value != null) {
        listaPertencias.add(Pertenencia(
            coste: value["coste"] ?? "",
            descripcion: value["descripcion"] ?? "",
            fecha: value["fecha"] ?? "",
            nombre: value["nombre"],
            imagen: value["imagen"] ?? "",
            docId: key));
      }
    });
    notifyListeners();
  }

  // FUNCION PARA ELIMINAR UNA PERTENCIA
  deletePertenencia({required BuildContext context, required String id}) async {
    final response = await http.delete(Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/pertenencia/$id.json'));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Pertencia eliminado correctamente',
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error al eliminar Pertencia',
        ),
        backgroundColor: Colors.red,
      ));
    }
    fetchPertenencias();
  }
}
