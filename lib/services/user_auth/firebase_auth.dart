import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_firebase_login/models/user.dart';
import 'package:todo_app_firebase_login/services/user_auth/firebase_firestore.dart';

class AuthServices {
  Future<UserModel?> signUpUser(
      String name, String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);
    await FirestoreServices.saveUser(name, email, userCredential.user!.uid);
    final User? firebaseUser = userCredential.user;
    return UserModel(
        id: firebaseUser?.uid,
        email: firebaseUser?.email,
        name: firebaseUser?.displayName);
  }

  Future<void> signOut() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<UserModel?> signInUser(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
  }
}
