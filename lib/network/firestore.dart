import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:today_do/model/base.dart';

class FirestoreProvider {

  Future<DocumentSnapshot> get(DocumentReference ref) => ref.get();

  Stream<QuerySnapshot> listen(CollectionReference ref) => ref.snapshots();

  Future<void> delete(DocumentReference ref) => ref.delete();

  Future<void> create(DocumentReference ref, Map<String, dynamic> data) => ref.setData(data);

}