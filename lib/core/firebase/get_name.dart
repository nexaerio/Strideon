import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetName extends StatelessWidget {
  const GetName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getNameStream(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          var getName = snapshot.data!['name'];
          return Text(
            getName,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
            softWrap: true,
          );
        } else {
          return const Text('No name');
        }
      },
    );
  }
}

Stream<DocumentSnapshot> getNameStream() {
  final firebaseAuth = FirebaseAuth.instance;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .snapshots();
}
