import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/provider.dart';
import 'package:strideon/models/workspace_model.dart';

final workSpaceProvider = Provider((ref) {
  return WorkspaceRepository(firestore: ref.watch(firestoreProvider));
});

class WorkspaceRepository {
  final FirebaseFirestore _firestore;

  WorkspaceRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future createWorkspace(WorkSpace workSpace) async {
    try {
      var workspaceDoc = await _workSpace.doc(workSpace.name).get();

      if (workspaceDoc.exists) {
        throw 'Workspace with the same name already exists';
      }


      return _workSpace.doc(workSpace.name).set(workSpace.toMap());
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  Stream<List<WorkSpace>> getUserWorkSpace(String uid) {
    return _workSpace
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<WorkSpace> workspace = [];
      for (var doc in event.docs) {
        workspace.add(WorkSpace.fromMap(doc.data() as Map<String, dynamic>));
      }
      return workspace;
    });
  }

  Future editWorkSpace(WorkSpace workSpace) async {
    try {
      _workSpace.doc(workSpace.name).update(workSpace.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<WorkSpace> getWorkSpaceByName(String name) {
    return _workSpace.doc(name).snapshots().map(
        (event) => WorkSpace.fromMap(event.data() as Map<String, dynamic>));
  }

  Future joinWorkSpace(String workSpaceName, String userId) async {
    try {
      return _workSpace.doc(workSpaceName).update({
        'members': FieldValue.arrayUnion([userId]),
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      e.toString();
    }
  }

  Future leaveWorkSpace(String workSpaceName, String userId) async {
    try {
      _workSpace.doc(workSpaceName).update({
        'members': FieldValue.arrayRemove([userId]),
      });
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  Stream<List<WorkSpace>> searchCommunity(String query) {
    return _workSpace
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<WorkSpace> communities = [];
      for (var community in event.docs) {
        communities
            .add(WorkSpace.fromMap(community.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

  Future addMods(String workSpace, List<String> uid) async {
    try {
      _workSpace.doc(workSpace).update({'mods': uid});
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  CollectionReference get _workSpace => _firestore.collection('workspace');
}
