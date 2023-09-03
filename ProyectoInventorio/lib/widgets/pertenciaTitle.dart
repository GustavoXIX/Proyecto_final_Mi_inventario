import 'package:invetariopersonal/Pages/AniadirPertenecia.dart';
import 'package:invetariopersonal/Pages/DetallesPertenenciaPage.dart';
import 'package:invetariopersonal/Imports/import.dart';

class PertenenciaTile extends StatelessWidget {
  final Pertenencia? pertenencia;
  const PertenenciaTile({super.key, this.pertenencia});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CRUDOperationProvider>(context);
    return Card(
      child: GestureDetector(
        child: ListTile(
          title: Text(pertenencia!.nombre),
          subtitle: Text("${pertenencia!.descripcion}"),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddNewPertenenciaPage(
                              pertenencia: pertenencia,
                            )));
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    provider.deletePertenencia(
                        context: context, id: pertenencia!.docId);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
             builder: (_) => DetallesPertenenciaPage(pertenencia: pertenencia),
          ));
        },
      ),
    );
  }
}
