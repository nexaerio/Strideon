import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KanbanRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  KanbanRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })
      : _firestore = firestore,
        _auth = auth;
}