import 'package:invetariopersonal/Pages/AniadirPertenecia.dart';
import 'package:invetariopersonal/Pages/DetallesPertenenciaPage.dart';
import 'package:invetariopersonal/Imports/import.dart';

class PertenenciaTile extends StatelessWidget {
  final Pertenencia? pertenencia;
  final bool? listaPer;
  PertenenciaTile({super.key, this.pertenencia, this.listaPer});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CRUDOperationProvider>(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: ListTile(
              title: Text(pertenencia!.nombre),
              subtitle: Text("${pertenencia!.descripcion}"),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => AddNewPertenenciaPage(
                                  pertenencia: pertenencia,
                                )));

                        Future.delayed(const Duration(milliseconds: 500), () {
                          provider.nombreController.clear();
                          provider.descripcionController.clear();
                          provider.costeController.clear();
                          provider.fechaController.clear();
                          provider.imageUrlController.clear();
                        });
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
                builder: (_) =>
                    DetallesPertenenciaPage(pertenencia: pertenencia),
              ));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: listaPer != true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/Loading1.gif',
                image: pertenencia?.imagen as String,
                fadeInDuration: const Duration(milliseconds: 500),
                // provider.imageUrlController.text,
                height: 440,
                width: 440,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                // Ejemplo
                imageErrorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // Esta función se llama en caso de que se produzca un error al cargar la imagen.
                  // Puedes personalizar el widget de error aquí. Por ejemplo, mostrar una imagen de error.
                  return Image.asset(
                    'assets/NoHayImagen.jpg',
                    height: 440,
                    width: 440,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
