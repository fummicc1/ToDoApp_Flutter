import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {

  Stream<DocumentSnapshot> listenDocument(DocumentReference ref) => ref.snapshots();

  Future<DocumentSnapshot> getDocument(DocumentReference ref) => ref.get();

  Stream<QuerySnapshot> listenCollection(CollectionReference ref) => ref.snapshots();

  Stream<QuerySnapshot> listenQuery(Query query) => query.snapshots();

  Future<QuerySnapshot> getQuery(Query query) => query.getDocuments();

  Future<void> delete(DocumentReference ref) => ref.delete();

  Future<void> create(DocumentReference ref, Map<String, dynamic> data) => ref.setData(data);
}