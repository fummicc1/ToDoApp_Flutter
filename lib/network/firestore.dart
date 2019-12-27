import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:today_do/model/base.dart';

class FirestoreProvider {

  Stream<DocumentSnapshot> listenDocument(DocumentReference ref) => ref.snapshots();

  Future<DocumentSnapshot> getDocument(DocumentReference ref) => ref.get();

  Stream<QuerySnapshot> listenCollection(CollectionReference ref) => ref.snapshots();

  Future<void> delete(DocumentReference ref) => ref.delete();

  Future<void> create(DocumentReference ref, Map<String, dynamic> data) => ref.setData(data);

  Future<void> createIfEmpty(DocumentReference ref) => ref.get().catchError((error) {
    print(error);
    ref.setData({});
  });
}