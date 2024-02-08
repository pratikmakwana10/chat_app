import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of Auth(),
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 // get current user ()
  User? getCurrentuser (){
    return _auth.currentUser;
  } 
  // sign In(),
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save user data to Seperate doc
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
      });
      return userCredential; // Add this line to return the UserCredential
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

// sign Up(),
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password) async {
    try {
      // create user
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save user data to Seperate doc
      _firestore.collection('users').doc(userCred.user!.uid).set({
        'email': userCred.user!.email,
        'uid': userCred.user!.uid,
      });
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // sign Out(),
  Future<void> signOut() async {
    await _auth.signOut();
  }
  // Errors(),
}

// This is where the authentication logic will be implemented
// This will be a singleton class
// This class will be used to authenticate users
// This class will be used to sign in and sign out users
// This class will be used to register users
// This class will be used to send password reset emails
// This class will be used to update user profiles
// This class will be used to delete user accounts
// This class will be used to get the current user
// This class will be used to check if a user is signed in
// This class will be used to get the user's id
// This class will be used to get the user's email
// This class will be used to get the user's display name
// This class will be used to get the user's photo url
// This class will be used to get the user's phone number
