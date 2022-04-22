import 'package:flutter/material.dart';
import 'package:study_flutter_firestore/app/pages/add_purchase/add_purchase_page.dart';
import 'package:study_flutter_firestore/app/pages/home/home_page.dart';
import 'package:study_flutter_firestore/app/pages/purchase_details/purchase_details_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add_purchase': (context) => const AddPurchasePage(),
        '/purchase_details': (context) => const PurchaseDetailsPage(),
      },
    );
  }
}
