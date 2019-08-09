import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/user.dart';

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
    // TODO: implement toString
    return super.toString();
  }
}

class AuthAuthorized extends AuthState {
  final User user;

  AuthAuthorized(this.user) : super([user]);
  @override
  String toString() {
    return "Logged in : ${user.fullName}";
  }
}
