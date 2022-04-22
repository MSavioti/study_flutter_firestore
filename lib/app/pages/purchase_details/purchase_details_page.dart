import 'package:flutter/material.dart';
import 'package:study_flutter_firestore/app/shared/models/purchase.dart';

class PurchaseDetailsPage extends StatelessWidget {
  const PurchaseDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Purchase purchase =
        ModalRoute.of(context)?.settings.arguments as Purchase;

    return Scaffold(
      appBar: AppBar(
        title: Text(purchase.date.toString()),
      ),
      body: ListView.builder(
        itemCount: purchase.products.length,
        itemBuilder: (_, i) {
          final product = purchase.products[i];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text(product.price.toString()),
            ),
          );
        },
      ),
    );
  }
}
