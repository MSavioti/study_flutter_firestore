import 'package:study_flutter_firestore/app/shared/models/product.dart';

class Purchase {
  String? id;
  DateTime date;
  List<Product> products;

  Purchase({
    this.id,
    required this.date,
    required this.products,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    final listedProducts = List.from(json['products']);
    final extractedProducts = <Product>[];

    for (var p in listedProducts) {
      final product = Product.fromJson(p);
      extractedProducts.add(product);
    }

    return Purchase(
      date: json['date'],
      products: extractedProducts,
    );
  }

  Map<String, dynamic> toJson() {
    final mappedProducts = <String, dynamic>{};

    for (var p in products) {
      final product = p.toJson();
      mappedProducts.addAll(product);
    }

    final map = <String, dynamic>{
      'document_id': id,
      'date': date,
      'products': mappedProducts,
    };

    return map;
  }

  double get totalPrice {
    var sum = 0.0;

    for (var p in products) {
      sum += p.price;
    }

    return sum;
  }
}
