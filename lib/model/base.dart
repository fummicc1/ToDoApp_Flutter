
import 'package:cloud_firestore/cloud_firestore.dart';

mixin BaseModel {

  DocumentReference ref;

  Map<String, dynamic> get json;

}