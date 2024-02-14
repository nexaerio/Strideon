import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/provider.dart';
import 'package:strideon/models/workspace_model.dart';

final firebaseStorageProvider =
    StateNotifierProvider<StorageRepository, bool>((ref) => StorageRepository(
          firebaseStorage: ref.watch(storageProvider),
          firestore: ref.watch(firestoreProvider),
          auth: ref.watch(authProvider),
        ));

class StorageRepository extends StateNotifier<bool> {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  StorageRepository({
    required FirebaseStorage firebaseStorage,
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firebaseStorage = firebaseStorage,
        _firestore = firestore,
        _auth = auth,
        super(false);

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    String id,
  ) async {
    Reference ref = _firebaseStorage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveUserData({
    String? name,
    Uint8List? file,
  }) async {
    String resp = "Some Error Occurred";

    try {
      if (name != null || file != null) {
        String imageUrl = '';

        if (file != null) {
          imageUrl = await uploadImageToStorage(
              'profilePic', file, 'users/profilePic${_auth.currentUser!.uid}');
        }

        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          if (name != null) 'name': name,
          if (file != null) 'profilePic': imageUrl,
        });

        resp = 'Success';
      } else {
        resp = 'No data to update';
      }
    } catch (e) {
      resp = e.toString();
    }

    return resp;
  }

  Future<String> saveWorkSpaceData({
    required Uint8List? bannerFile,
    required Uint8List? profileFile,
    required WorkSpace workSpace,
  }) async {
    String resp = "Some Error Occurred";

    try {
      if (profileFile != null) {
        String workSpaceProfileUrl = await uploadImageToStorage(
            'workSpaceProfile',
            profileFile,
            'workspace/avatarPic${workSpace.name}');
        workSpace.copyWith(avatar: 'p');

        if (bannerFile != null) {
          String workSpaceBannerUrl = await uploadImageToStorage(
              'workSpaceBanner',
              bannerFile,
              'workspace/bannerPic${workSpace.name}');
          workSpace.copyWith(banner: 'b');

          _firestore.collection('workspace').doc(workSpace.name).update({
            'avatar': workSpaceProfileUrl,
            'banner': workSpaceBannerUrl,
          }).toString();

          // _ref.read(workSpaceProvider).editWorkSpace(workSpace);

          resp = 'Success';
        }
      }
    } catch (e) {
      e.toString();
    }

    return resp;
  }
}
