import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TestPastPostFirebaseUser {
  TestPastPostFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

TestPastPostFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TestPastPostFirebaseUser> testPastPostFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<TestPastPostFirebaseUser>(
            (user) => currentUser = TestPastPostFirebaseUser(user));
