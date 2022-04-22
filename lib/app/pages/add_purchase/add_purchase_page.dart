import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter_firestore/app/shared/models/product.dart';
import 'package:study_flutter_firestore/app/shared/models/purchase.dart';
import 'package:study_flutter_firestore/app/shared/repositories/data_repository.dart';

class AddPurchasePage extends StatefulWidget {
  const AddPurchasePage({Key? key}) : super(key: key);

  @override
  State<AddPurchasePage> createState() => _AddPurchasePageState();
}

class _AddPurchasePageState extends State<AddPurchasePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _productNameControllers = [];
  final List<TextEditingController> _productPriceControllers = [];
  int _productsCount = 0;

  @override
  void initState() {
    _addProductField();
    super.initState();
  }

  void _addProductField() {
    setState(() {
      _productsCount++;
      _productNameControllers.add(TextEditingController());
      _productPriceControllers.add(TextEditingController());
    });
  }

  void _removeLastProductField() {
    setState(() {
      _productNameControllers.removeLast();
      _productPriceControllers.removeLast();
      _productsCount--;
    });
  }

  void _removeProductFieldAt(int index) {
    setState(() {
      _productNameControllers.removeAt(index);
      _productPriceControllers.removeAt(index);
      _productsCount--;
    });
  }

  void _submit() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fill all the remaining fields.'),
        ),
      );
      return;
    }

    final products = <Product>[];

    for (var i = 0; i < _productsCount; i++) {
      final price =
          _productPriceControllers[i].text.replaceAll(',', '.').substring(4, 7);

      final product = Product(
        name: _productNameControllers[i].text,
        price: double.tryParse(price) ?? 0.0,
      );

      products.add(product);
    }

    final purchase = Purchase(
      date: DateTime.now(),
      products: products,
    );

    DataRepository.instance.addPurchase(purchase);
  }

  String? _validateTextField(String? inputText) {
    if ((inputText == null) || (inputText.isEmpty)) {
      return 'This field can\'t be left blank';
    }

    return null;
  }

  String? _validateCurrencyField(String? inputText) {
    if ((inputText == null) || (inputText.isEmpty)) {
      return 'This field can\'t be left blank';
    }

    if (!inputText.contains('BRL')) {
      return 'Wrong currency format';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add purchase')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var i = 0; i < _productsCount; i++)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        color: const Color.fromARGB(255, 185, 226, 245),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () => _removeProductFieldAt(i),
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            TextFormField(
                              autofocus: i == 0,
                              controller: _productNameControllers[i],
                              validator: _validateTextField,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'Product\'s name...',
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _productPriceControllers[i],
                              validator: _validateCurrencyField,
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                  decimalDigits: 2,
                                  locale: 'pt-br',
                                ),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Price',
                                hintText: 'Product\'s price...',
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('SUBMIT'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProductField,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
