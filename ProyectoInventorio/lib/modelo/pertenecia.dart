class Pertenencia {
  String nombre;
  String? descripcion;
  String? fecha;
  String? coste;
  String? imagen;
  String docId;

  Pertenencia(
      {required this.nombre,
      this.descripcion,
      this.fecha,
      this.coste,
      this.imagen,
      required this.docId});
}
