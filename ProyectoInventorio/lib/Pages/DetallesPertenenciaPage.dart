import 'package:flutter/material.dart';
import '../Imports/import.dart';

class DetallesPertenenciaPage extends StatefulWidget {
  final Pertenencia? pertenencia;
  const DetallesPertenenciaPage({super.key, this.pertenencia});

  @override
  // ignore: library_private_types_in_public_api
  _DetallesPertenenciaPageState createState() =>
      _DetallesPertenenciaPageState();
}

class _DetallesPertenenciaPageState extends State<DetallesPertenenciaPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Puedes acceder a widget.pertenencia para obtener la Pertenencia aquí
    final Pertenencia? pertenencia = widget.pertenencia;
    ScreenUtil.init(context);
    // Calcula la altura de la pantalla en un 60%
    double screenHeight = ScreenUtil().screenHeight * 0.6;
    //final provider = Provider.of<CRUDOperationProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          // Espacio de 20.0 en todos los lados
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/Loading1.gif',
                  image: pertenencia?.imagen as String,
                  fadeInDuration: const Duration(milliseconds: 500),
                  // provider.imageUrlController.text,
                  height: screenHeight,
                  fit: BoxFit.cover,

                  // Ejemplo
                  width: double.infinity,
                  imageErrorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // Esta función se llama en caso de que se produzca un error al cargar la imagen.
                    // Puedes personalizar el widget de error aquí. Por ejemplo, mostrar una imagen de error.
                    return Image.asset(
                      'assets/NoHayImagen.jpg',
                      height: screenHeight,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                pertenencia!.nombre,
                style: const TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Descripción: ${pertenencia.descripcion} ',
                style: const TextStyle(fontSize: 18.0, fontFamily: 'Arial'),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Coste: \€${pertenencia.coste ?? 0.00}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Fecha de compra: ${pertenencia.fecha ?? DateTime.now}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ));
  }
}
