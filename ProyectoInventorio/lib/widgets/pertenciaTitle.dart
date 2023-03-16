import 'package:flutter/material.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/modelo/pertenecia.dart';
import 'package:invetariopersonal/pages/add_pertenencia.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PertenenciaTile extends StatelessWidget {
  final Pertenencia? pertencia;
  const PertenenciaTile({super.key, this.pertencia});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CRUDOperationProvider>(context);
    return Card(
      child: ListTile(
        title: Text(pertencia!.nombre),
        subtitle: Text("${pertencia!.descripcion}"),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  // Editar usuario
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddNewPertenenciaPage(
                            pertenencia: pertencia,
                          )));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Eliminar Usuario
                  provider.deletePertenencia(
                      context: context, id: pertencia!.docId);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
