class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final List images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      images: json['images'],
    );
  }
}
