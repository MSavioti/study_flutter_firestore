import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_flutter_firestore/app/shared/models/purchase.dart';
// import 'package:study_flutter_firestore/app/shared/models/contact.dart';

class DataRepository {
  late CollectionReference collectionReference;

  DataRepository._() {
    collectionReference = FirebaseFirestore.instance.collection('purchases');
  }

  static DataRepository? _instance;

  static DataRepository get instance => _instance ??= DataRepository._();

  Stream<QuerySnapshot> getStream() {
    return collectionReference.snapshots();
  }

  Future<DocumentReference> addPurchase(Purchase purchase) {
    return collectionReference.add(purchase.toJson());
  }

  // void updatePet(Pet pet) async {
  //   await collection.doc(pet.referenceId).update(pet.toJson());
  // }

  void deletePurchase(String id) async {
    await collectionReference.doc(id).delete();
  }
}
