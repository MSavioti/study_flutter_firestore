import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flutter_firestore/app/shared/models/product.dart';

class Purchase {
  DateTime date;
  List<Product> products;

  Purchase({
    required this.date,
    required this.products,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    final listedProducts = json['products'] as List;
    final extractedProducts = <Product>[];

    for (var p in listedProducts) {
      final product = Product.fromJson(p);
      extractedProducts.add(product);
    }

    final Timestamp timestamp = json['date'];

    return Purchase(
      date: timestamp.toDate(),
      products: extractedProducts,
    );
  }

  Map<String, dynamic> toJson() {
    final mappedProducts = [];

    for (var p in products) {
      final product = p.toJson();
      mappedProducts.add(product);
    }

    final map = <String, dynamic>{
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
