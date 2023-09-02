// ignore: file_names
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Service/auth.dart';
import 'package:invetariopersonal/Models/pertenecia.dart';
import 'package:invetariopersonal/Pages/AniadirPertenecia.dart';
import 'package:invetariopersonal/widgets/pertenciaTitle.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index = 0;
  late List<Pertenencia> listaPertenencias = [];
  var listaPer = true;
  Icon iconoLista = new Icon(Icons.view_list_rounded); 
  Icon iconoImagen = new Icon( Icons.view_carousel_outlined); 
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CRUDOperationProvider>(context);
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                provider.nombreController.clear();
                provider.descripcionController.clear();
                provider.costeController.clear();
                provider.fechaController.clear();
                provider.imageUrlController.clear();
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const AddNewPertenenciaPage()),
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(height: 16.0), // Espacio entre los botones
          FloatingActionButton(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
               provider.fetchPertenencias();
              if (listaPer) {
                listaPer = false;
              } else {
                listaPer = true;
              }
            },
            tooltip: 'Vista',
            child: listaPer ? iconoLista: iconoImagen,
          ),
        ],
      ),
      body: listaPer
          ? RefreshIndicator(
              onRefresh: () => provider.fetchPertenencias(),
              child: Swiper(
                itemBuilder: (context, index) {
                  final pertenencia = provider.listaPertenencias[index];
                  return PertenenciaTile(
                    pertencia: pertenencia,
                  );
                },
                itemCount: provider.listaPertenencias.length,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => provider.fetchPertenencias(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return PertenenciaTile(
                        pertencia: provider.listaPertenencias[index]);
                  },
                  itemCount: provider.listaPertenencias.length,
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                founsSignout(context);
                //  Statechange();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
