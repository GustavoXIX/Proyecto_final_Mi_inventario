import 'package:flutter/material.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Service/auth.dart';
import 'package:invetariopersonal/Models/pertenecia.dart';
import 'package:invetariopersonal/Pages/AniadirPertenecia.dart';
import 'package:invetariopersonal/widgets/pertenciaTitle.dart';
import 'package:provider/provider.dart';

const COLLECTION_NAME = 'colecion_pertenencia';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late List<Pertenencia> listaPertenencia = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CRUDOperationProvider>(context);

    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNewPertenenciaPage()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchPertenencias(),
        child: Padding(
          padding: EdgeInsets.all(5.0),
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
              icon: Icon(Icons.logout),
              onPressed: () {
                founsSignout();
                Statechange();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
