import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:strideon/core/firebase/firebase_constants.dart';
import 'package:strideon/core/provider/firebase_provider.dart';
import 'package:strideon/feature/auth/views/auth_view/forget_password_page.dart';
import 'package:strideon/feature/auth/views/auth_view/register_screen.dart';
import 'package:strideon/models/user_model.dart';
import 'package:strideon/utils/constants/image_strings.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
    firestore: ref.read(firestoreProvider)));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthRepository(
      {required FirebaseAuth auth,
      required GoogleSignIn googleSignIn,
      required FirebaseFirestore firestore})
      : _auth = auth,
        _googleSignIn = googleSignIn,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'No Name',
          profilePic: userCredential.user!.photoURL ?? SImages.avatarDefault,
          banner: SImages.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future createUserWithEmail(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      UserModel userModel;

      if (credential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: nameController.text,
          profilePic: credential.user!.photoURL ?? SImages.avatarDefault,
          banner: SImages.bannerDefault,
          uid: credential.user!.uid,
          isAuthenticated: true,
        );
        await _users.doc(credential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(credential.user!.uid).first;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

/*// Function to send a verification email
  Future sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('Verification email sent. Please check your inbox.');
    }
  }*/

  Future signInWithEmail(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      UserModel userModel;

      userModel = await getUserData(credential.user!.uid).first;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future passwordReset() async {
    try {
      await _auth.sendPasswordResetEmail(
          email: forgetPasswordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
