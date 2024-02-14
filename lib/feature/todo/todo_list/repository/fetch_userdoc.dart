import 'package:cloud_firestore/cloud_firestore.dart';

// Assuming 'users' is the collection and 'name' is the document ID
Future<void> fetchData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot document = await firestore.collection('users').doc('name').get();

  // Access the data using document.data() or document.get('fieldName')
  if (document.exists) {
    print('Document data: ${document.data()}');
  } else {
    print('Document does not exist');
  }
}
