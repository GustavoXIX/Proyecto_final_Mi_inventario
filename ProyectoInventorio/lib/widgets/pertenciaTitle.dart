import 'package:flutter/material.dart';
import 'package:invetariopersonal/Provider/provider.dart';
import 'package:invetariopersonal/Models/pertenecia.dart';
import 'package:invetariopersonal/Pages/AniadirPertenecia.dart';
import 'package:provider/provider.dart';

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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddNewPertenenciaPage(
                            pertenencia: pertencia,
                          )));
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () {
                  provider.deletePertenencia(
                      context: context, id: pertencia!.docId);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
