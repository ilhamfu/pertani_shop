import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AuthLogInFB extends AuthEvent {
  @override
  String toString() {
    return "Loggin in with Facebook";
  }
}

class AuthLogInGoogle extends AuthEvent {
  @override
  String toString() {
    return "Loggin in with Google";
  }
}

class AuthLogInUsername extends AuthEvent {
  final String email;
  final String password;

  AuthLogInUsername(this.email, this.password) : super([email, password]);

  @override
  String toString() {
    return "Logging in with Email";
  }
}

class AuthLogOut extends AuthEvent {
  @override
  String toString() {
    return "Logging out";
  }
}
