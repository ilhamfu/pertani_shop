import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class AuthUnauthorized extends AuthState {
  @override
  String toString() {
    return "Not authorized";
  }
}

class AuthLoggingIn extends AuthState {
  @override
  String toString() {
    return "Logging in";
  }
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error) : super([error]);
  @override
  String toString() {
    return super.toString();
  }
}

class AuthLoggedIn extends AuthState {
  final FirebaseUser user;

  AuthLoggedIn(this.user) : super([user]);
  @override
  String toString() {
    return "Logged in : ${user.displayName}";
  }
}
