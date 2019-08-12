import 'package:pertani_shop/bloc/auth/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/auth/data_layer/repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  @override
  // TODO: implement initialState
  AuthState get initialState => AuthUnauthorized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // TODO: implement mapEventToState
    try {
      if (currentState is AuthUnauthorized) {
        yield AuthLoggingIn();
        if (event is AuthLogInGoogle) {
          final user = await _authRepository.googleSignIn();
          yield AuthLoggedIn(user);
          return;
        } else if (event is AuthLogInFB) {
          final user = await _authRepository.facebookSignIn();
          yield AuthLoggedIn(user);
          return;
        } else if (event is AuthLogInUsername) {
          final user = await _authRepository.emailSignIn(email: event.email,password: event.password);
          yield AuthLoggedIn(user);
          return;
        }
      }
      if (event is AuthLogOut){
        yield AuthUnauthorized();
      }

    } catch (e) {
      yield AuthError(e);
    }
  }
}
