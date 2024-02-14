import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetProfile extends StatefulWidget {
  const GetProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<GetProfile> createState() => _GetProfileState();
}

class _GetProfileState extends State<GetProfile> {
  late Stream<String?> _photoUrlStream;

  @override
  void initState() {
    super.initState();
    _photoUrlStream = getPhotoUrlStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: _photoUrlStream,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else if (snapshot.hasData && snapshot.data != null) {
          return CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(snapshot.data!),
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }

  Stream<String?> getPhotoUrlStream() {
    final firebaseAuth = FirebaseAuth.instance;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot['profilePic'] as String?);
  }
}
