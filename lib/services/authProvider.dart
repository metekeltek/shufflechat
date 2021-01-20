import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth firebaseAuth;
  //final FirebaseFirestore db;

  AuthProvider(
    this.firebaseAuth,
  );

  Stream<User> get authState => firebaseAuth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'success';
    } catch (e) {
      return e.code;
    }
  }

  Future<RegisterResult> register(String email, String password) async {
    RegisterResult registerResult = RegisterResult();
    try {
      var userCredentials = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      registerResult.uid = userCredentials.user.uid;
      return registerResult;
    } catch (e) {
      registerResult.error = true;
      registerResult.errorMessage = e.code;
      return registerResult;
    }
  }

  Future resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  Future deleteUser() async {
    await firebaseAuth.currentUser.delete();
  }

  String getUID() {
    return firebaseAuth.currentUser.uid;
  }

  Future<User> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }
}

class RegisterResult {
  bool error = false;
  String uid;
  String errorMessage;
}
