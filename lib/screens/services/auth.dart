import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/model/the_user.dart';
import 'package:login_firebase/screens/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TheUser? _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  Stream<TheUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // FirebaseUser = User (change new)
  // result = userCredential //(old) AuthResult change (new) UserCredential
  // sign in anon
  Future signInAnon() async {
    try {
      // result = userCredential //(old) AuthResult change (new) UserCredential
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
