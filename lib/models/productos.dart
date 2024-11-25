class Product {
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String url;
  final String career; // Nuevo campo para la carrera

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.career, // Inicializamos el campo
  });
}
