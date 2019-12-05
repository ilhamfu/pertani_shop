import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/auth/bloc/index.dart';
import 'package:pertani_shop/models/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthUnauthorized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogInFacebook) {
      yield* _mapLoginFacebookToState();
    } else if (event is AuthLogInGoogle) {
      yield* _mapLoginGoogleToState();
    } else if (event is AuthLogInTwitter) {
      yield* _mapLoginTwitterToState();
    } else if (event is AuthLogInPassword) {
      yield* _mapLoginPasswordToState(
          email: event.email, password: event.password);
    } else if (event is AuthLogOut) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    yield AuthUnauthorized();
  }

  Stream<AuthState> _mapLoginPasswordToState(
      {String email, String password}) async* {
    yield AuthAuthorized(
        user: User(
            active: true,
            address: "",
            city: "",
            province: "",
            complete: true,
            email: "",
            firstName: "",
            lastName: "",
            ktp: "",
            profileImage: "",
            verified: true));
  }

  Stream<AuthState> _mapLoginTwitterToState() async* {
    yield AuthAuthorized(
        user: User(
            active: true,
            address: "",
            city: "",
            province: "",
            complete: true,
            email: "",
            firstName: "",
            lastName: "",
            ktp: "",
            profileImage: "",
            verified: true));
  }

  Stream<AuthState> _mapLoginGoogleToState() async* {
    yield AuthAuthorized(
        user: User(
            active: true,
            address: "",
            city: "",
            province: "",
            complete: true,
            email: "",
            firstName: "",
            lastName: "",
            ktp: "",
            profileImage: "",
            verified: true));
  }

  Stream<AuthState> _mapLoginFacebookToState() async* {
    yield AuthAuthorized(
        user: User(
            active: true,
            address: "",
            city: "",
            province: "",
            complete: true,
            email: "",
            firstName: "",
            lastName: "",
            ktp: "",
            profileImage: "",
            verified: true));
  }
}
