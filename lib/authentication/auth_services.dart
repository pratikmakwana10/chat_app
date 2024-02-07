import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of Auth(),
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // sign In(),
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential; // Add this line to return the UserCredential
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
// sign Up(),
Future<UserCredential> signUpWithEmailAndPassword (String email,password)async{
  try{
  UserCredential userCred = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  return userCred;
  } on FirebaseAuthException catch (e){
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