class Product {
  final String? id;
  final String name;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['document_id'],
      name: json['name'],
      price: json['price'].toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'document_id': id,
      'name': name,
      'price': price.toString(),
    };
  }
}
