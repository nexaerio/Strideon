import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strideon/models/user_model.dart';
import 'package:strideon/utils/constants/image_strings.dart';

class UserDataService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      if (userSnapshot.exists) {
        // User data found in Firestore
        Map<String, dynamic> userDataMap =
            userSnapshot.data() as Map<String, dynamic>;

        String? name = userDataMap['name'];
        String? imagePath = userDataMap['profilePic'];
        File? image;
        if (imagePath != null) {
          image = File(imagePath);
        }

        return UserModel.fromMap(userDataMap);
      } else {
        return UserModel(
          name: "Guest",
          profilePic: SImages.avatarDefault,
          banner: SImages.bannerDefault,
          uid: userId,
          isAuthenticated: false,
        );
      }
    } catch (e) {
      print("Error fetching user data: $e");
      rethrow; // Handle the error according to your application's needs
    }
  }
}
