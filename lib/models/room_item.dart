class RoomItem {
  final String name;
  final String hint; // la pista que se muestra al tocar el objeto
  final double top;
  final double left;
  final double width;
  final double height;
  final String code; // código que desbloquea el objeto

  RoomItem({
    required this.name,
    required this.hint,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.code,
  });
}
