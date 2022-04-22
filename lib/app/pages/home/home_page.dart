import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter_firestore/app/shared/models/purchase.dart';
import 'package:study_flutter_firestore/app/shared/repositories/data_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: StreamBuilder<QuerySnapshot>(
        stream: DataRepository.instance.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final itemCount = snapshot.data!.docs.length;

          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (_, i) {
              final documentSnapshot = snapshot.data!.docs[i];
              final purchase = Purchase.fromJson(
                  documentSnapshot.data() as Map<String, dynamic>);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(purchase.date.toString()),
                  subtitle: Text('${purchase.products.length} products'),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => DataRepository.instance
                              .deletePurchase(documentSnapshot.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/purchase_details',
                              arguments: purchase,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_purchase');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shopify_outlined),
      ),
    );
  }
}
