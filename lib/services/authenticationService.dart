import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registrationpage/databaseManager/databaseManager.dart';


class AuthenticationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String name, String mobile, String email, String password, String location) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      sendVerificationEmail();
      await DatabaseManager().createUserData(name, mobile, email, password, location, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  void sendVerificationEmail() async {
    User firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser.sendEmailVerification();

    Fluttertoast.showToast(
        msg: "Email verifcation link has sent to your email.");


  }

// sign with email and password

  Future loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

// signout

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
