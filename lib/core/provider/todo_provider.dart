import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/firebase/firebase_constants.dart';

import 'package:strideon/models/todo_model.dart';

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  User? user = FirebaseAuth.instance.currentUser;

  final getData = FirebaseFirestore.instance
      .collection(FirebaseConstants.todoCollection)
      .where(FirebaseConstants.docID, isEqualTo: user?.uid)
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());

  yield* getData;
});
