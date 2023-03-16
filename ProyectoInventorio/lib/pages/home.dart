import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Service/auth.dart';
import 'package:invetariopersonal/combonent/CustomButton.dart';
import 'package:invetariopersonal/modelo/pertenecia.dart';
import 'package:invetariopersonal/pages/add_pertenencia.dart';
import 'package:invetariopersonal/rigester/Signin.dart';
import 'package:invetariopersonal/widgets/pertenciaTitle.dart';
import 'package:provider/provider.dart';

const COLLECTION_NAME = 'colecion_pertenencia';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final _formkeyemail = GlobalKey<FormState>();

  final _formkeypassword = GlobalKey<FormState>();

  final List<Pertenencia> listaPertenencia = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CRUDOperationProvider>(context);
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNewPertenenciaPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchPertenencias(),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return PertenenciaTile(
                  pertencia: provider.listaPertencias[index]);
            },
            itemCount: provider.listaPertencias.length,
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
