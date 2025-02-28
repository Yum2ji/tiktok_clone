import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
 특정 어플에서 A 사용자가 B 사용자 관련 정보에 접근하는데
 이런거는 authentication 특징으로 안됨 -> firestore로 해야함.
 아래 내용은 authentication
 */
class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  Future<UserCredential> emailSignUp(String email, String password) async {
    return await  _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> githubSignIn() async{
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }

}

final authRepo = Provider(
  (ref) => AuthenticationRepository(),
);

final authState = StreamProvider(
  (ref) {
    final repo = ref.read(authRepo);
    return repo.authStateChanges();
  },
);
