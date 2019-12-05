import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AuthLogInFacebook extends AuthEvent {}

class AuthLogInTwitter extends AuthEvent {}

class AuthLogInGoogle extends AuthEvent {}

class AuthLogOut extends AuthEvent {}

class AuthLogInPassword extends AuthEvent {
  final String email;
  final String password;

  AuthLogInPassword({this.email, this.password}) : super([email, password]);
}
