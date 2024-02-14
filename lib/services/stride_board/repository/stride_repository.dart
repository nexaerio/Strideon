import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/firebase_provider.dart';
import 'package:strideon/models/create_board_model.dart';

final boardProvider = Provider((ref) {
  return StrideRepository(firestore: ref.watch(firestoreProvider));
});

class StrideRepository {
  final FirebaseFirestore _firestore;

  StrideRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future createBoard(CreateBoard createBoard) async {
    try {
      var workspaceDoc = await _strideBoard.doc(createBoard.boardName).get();
      var user = FirebaseAuth.instance.currentUser!.uid;

      if (workspaceDoc.exists) {
        var workspaceOwner = workspaceDoc['strideBoard'];
        if (workspaceOwner == user) {
          throw 'You already own a workspace with the same name';
        } else {}
      }

      return _strideBoard.doc(createBoard.boardName).set(createBoard.toMap());
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  Stream<List<CreateBoard>> getUserBoard(String uid) {
    return _strideBoard.where('id', isEqualTo: uid).snapshots().map((event) {
      List<CreateBoard> workspace = [];
      for (var doc in event.docs) {
        workspace.add(CreateBoard.fromMap(doc.data() as Map<String, dynamic>));
      }
      return workspace;
    });
  }

  Stream<CreateBoard> getStrideByName(String name) {
    return _strideBoard.doc(name).snapshots().map(
        (event) => CreateBoard.fromMap(event.data() as Map<String, dynamic>));
  }

  void deleteStrideBoard(String? uid) {
    _strideBoard.doc(uid).delete();
  }

  CollectionReference get _strideBoard => _firestore.collection('strideBoard');
}
