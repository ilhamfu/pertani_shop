import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/user.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class AuthUnauthorized extends AuthState {}

class AuthAuthorized extends AuthState {
  final User user;

  AuthAuthorized({this.user}) : super([user]);
}

class AuthStatus extends AuthState {
  final int statusCode;

  static const AuthLoggingIn = 0;
  static const AuthLoggingOut = 1;

  AuthStatus({this.statusCode}) : super([statusCode]);
}
