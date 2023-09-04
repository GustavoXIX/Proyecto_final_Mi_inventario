import 'package:flutter/material.dart';
import 'package:invetariopersonal/Imports/import.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Models/pertenecia.dart';
import 'package:invetariopersonal/widgets/calendario.dart';
import 'package:provider/provider.dart';

import '../widgets/ImageInput.dart';

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
    //DESCOMENTAR
    // provider.fetchPertenencias();
    if (widget.pertenencia != null) {
      provider.nombreController =
          TextEditingController(text: widget.pertenencia!.nombre);
      provider.descripcionController =
          TextEditingController(text: widget.pertenencia!.descripcion);
      provider.costeController =
          TextEditingController(text: widget.pertenencia!.coste.toString());
      provider.fechaController =
          TextEditingController(text: widget.pertenencia!.fecha.toString());
      provider.imageUrlController =
          TextEditingController(text: widget.pertenencia!.imagen);
    }
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
        ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.all(30.0), // Ajusta los valores según tus necesidades
        child: Form(
          key: provider.formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 20.0),
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
                    labelText: "Nombre",
                    prefixIcon: const Icon(Icons.phone_iphone_outlined),
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
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Descripcion",
                    prefixIcon: const Icon(Icons.messenger_outline_sharp),
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
                      return 'Por favor, introduzca fecha válida';
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Euros",
                      prefixIcon: const Icon(Icons.euro),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (provider.imageUrlController.text.isNotEmpty)
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Image.network(provider.imageUrlController.text),
                  )
                else
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ImageInput(provider.onSelectImage),
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
                              provider.updatePertenencia(
                                context: context,
                                id: widget.pertenencia!.docId,
                              );
                            } else {
                              provider.sendPertenenciaOnFirebase(context);
                            }
                          }
                        },
                        // DESCOMENTAR SI ES NECESARIO
                        // onPressed: () {
                        //   if (provider.formKey.currentState!.validate()) {
                        //     if (widget.pertenencia != null) {
                        //       print("Editar pertenencia");
                        //       provider.sendPertenenciaOnFirebase(context);
                        //     } else {
                        //       provider.updatePertenencia(
                        //           context: context,
                        //           id: widget.pertenencia!.docId);
                        //     }
                        //   }
                        // },
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Text(
                          widget.pertenencia != null
                              ? "Editar pertenencia"
                              : "Añadir pertenencia",
                          style: const TextStyle(
                            color: Colors
                                .white, // Cambiar el color del texto a blanco o al color deseado.
                            fontSize:
                                18.0, // Cambiar el tamaño del texto según tus preferencias.
                            // Puedes ajustar otras propiedades de estilo según sea necesario.
                          ),
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
