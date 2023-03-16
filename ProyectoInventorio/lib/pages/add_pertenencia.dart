import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/modelo/pertenecia.dart';
import 'package:invetariopersonal/widgets/calendario.dart';
import 'package:provider/provider.dart';

class AddNewPertenenciaPage extends StatefulWidget {
  final Pertenencia? pertenencia;
  const AddNewPertenenciaPage({super.key, this.pertenencia});

  @override
  State<AddNewPertenenciaPage> createState() => _AddNewPertenenciaPageState();
}

class _AddNewPertenenciaPageState extends State<AddNewPertenenciaPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CRUDOperationProvider>(context);
    if (widget.pertenencia != null) {
      provider.nombreController =
          TextEditingController(text: widget.pertenencia!.nombre);
      provider.descripcionController =
          TextEditingController(text: widget.pertenencia!.descripcion);
      provider.costeController =
          TextEditingController(text: widget.pertenencia!.coste.toString());
      provider.fechaController =
          TextEditingController(text: widget.pertenencia!.fecha.toString());
      provider.imagenController =
          TextEditingController(text: widget.pertenencia!.imagen);
    }
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: provider.formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 60.0, left: 10.0, right: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: provider.nombreController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduzca una pertenecia';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Nombre",
                    hintText: "Ordenador",
                    prefixIcon: const Icon(Icons.phone_iphone_outlined),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: null,
                  controller: provider.descripcionController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Descripcion",
                    hintText: "Es un dispositivo...",
                    prefixIcon: const Icon(Icons.messenger_outline_sharp),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CalendarFormField(
                  controller: provider.fechaController,
                  hintText: "dd/MM/yyyy",
                  labelText: "Fecha:",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduzca una fecha';
                    } else if (value.length < 10) {
                      return 'Por favor, introduzca fecha válido';
                    }
                    return null;
                  },
                  onDateSelected: (date) {
                    // do something with the selected date
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(right: 160.0),
                  child: TextFormField(
                    controller: provider.costeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduzca una descripcion';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Euros",
                      prefixIcon: const Icon(Icons.euro),
                      fillColor: Color.fromARGB(255, 17, 14, 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 160.0),
                  child: Container(
                    height: 180,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        // Widget para seleccionar o tomar una imagen
                        InkWell(
                          onTap: () async {
                            final pickedImage = await ImagePicker().getImage(
                              source: ImageSource.camera,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        // Widget para mostrar la imagen seleccionada o tomada
                        // Aquí se puede agregar la lógica para mostrar la imagen
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MaterialButton(
                        onPressed: () {
                          if (provider.formKey.currentState!.validate()) {
                            if (widget.pertenencia != null) {
                              print("Editar pertenencia");
                              provider.updatePertenencia(
                                  context: context,
                                  id: widget.pertenencia!.docId);
                            } else {
                              provider.sendPertenenciaOnFirebase(context);
                            }
                          } else {}
                        },
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Text(
                          widget.pertenencia != null
                              ? "Editar pertenencia"
                              : "Añadir pertenencia",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
