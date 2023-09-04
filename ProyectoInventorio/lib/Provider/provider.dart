import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/pertenecia.dart';

class CRUDOperationProvider extends ChangeNotifier {
  CRUDOperationProvider();
  List<Pertenencia?> listaPertenencias = [];
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController costeController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  bool isLoading = false;
  File? selectedImage;

  // FUNCION PARA AÑADIR PERTENENCIA\\
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
        "imagen": imageUrlController.text,
      }),
    );

    if (response.statusCode == 200) {
      nombreController.clear();
      descripcionController.clear();
      costeController.clear();
      fechaController.clear();
      imageUrlController.clear();
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
    String? imagenUrl,
  }) async {
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    final path = 'Usuarios/$userID/Pertenencias/$id';

    // Obtener la URL de la imagen desde la base de datos
    final urlResponse = await http.get(Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/$path.json'));
    final responseData = jsonDecode(urlResponse.body) as Map<String, dynamic>?;
    final imageUrl = responseData?['imagen'] as String?;

    if (selectedImage != null) {
      imageUrl;
      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error al cargar la nueva imagen.'),
          backgroundColor: Colors.red,
        ));
        return;
      }
    }
    final url = Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/Usuarios/$userID/Pertenencias/$id.json');

    final response = await http.patch(
      url,
      body: jsonEncode({
        "nombre": nombreController.text,
        "descripcion": descripcionController.text,
        "fecha": fechaController.text,
        "coste": costeController.text,
        "imagen": imageUrl,
      }),
    );

    if (response.statusCode == 200) {
      nombreController.clear();
      descripcionController.clear();
      costeController.clear();
      fechaController.clear();
      imageUrlController.clear();
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

    // Limpia el formulario después de mostrar la notificación
    Future.delayed(const Duration(milliseconds: 500), () {
      nombreController.clear();
      descripcionController.clear();
      costeController.clear();
      fechaController.clear();
      imageUrlController.clear();
    });
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
    final pertenenciasData = extractedData;

    if (pertenenciasData != null) {
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
    }
    notifyListeners();
  }

  // FUNCION PARA ELIMINAR UNA PERTENENCIA
  Future<void> deletePertenencia({
    required BuildContext context,
    required String id,
  }) async {
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    final path = 'Usuarios/$userID/Pertenencias/$id';

    // Obtener la URL de la imagen desde la base de datos
    final urlResponse = await http.get(Uri.parse(
        'https://aplicaciondeinventario-default-rtdb.europe-west1.firebasedatabase.app/$path.json'));
    final responseData = jsonDecode(urlResponse.body) as Map<String, dynamic>?;
    final imageUrl = responseData?['imagen'];

    // Eliminar la imagen en Firebase Storage si se proporcionó una URL de imagen
    if (imageUrl != null && imageUrl.isNotEmpty) {
      final Reference storageRef =
          FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
    }
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

  Future<void> onSelectImage(File? image) async {
    final inst = FirebaseAuth.instance;
    final userID = inst.currentUser?.uid;
    
    if (image != null) {
      // Guardar la imagen en una propiedad del proveedor
      this.selectedImage = image;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final FirebaseStorage storage = FirebaseStorage.instance;
      // Enviar la imagen a Firestore
      try {
        // Subir la imagen al Storage de Firebase
        final Reference reference = storage.ref().child(
            "usuarios/$userID/pertenencias/$fileName",);
        await reference.putFile(selectedImage as File);

        // Obtener la URL de descarga de la imagen
        String Url = await reference.getDownloadURL();

        // guardado en una propiedad del proveedor
        imageUrlController.text = Url;

        // Notificar a los consumidores del proveedor sobre el cambio
        notifyListeners();
      } catch (error) {
        // Manejar error que ocurra durante la carga de la imagen
        print('Error al cargar la imagen: $error');
      }
    }
  }
}
