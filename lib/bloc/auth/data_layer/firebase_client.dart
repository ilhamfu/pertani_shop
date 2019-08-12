import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pertani_shop/utils/coded_exception.dart';

class FirebaseAuthClient {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> facebookSignIn() async {
    FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logInWithReadPermissions(["email"]);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        throw CodedException(code: CodedException.FACEBOOK_AUTH_CANCELED);
        break;
      case FacebookLoginStatus.error:
        throw CodedException(code: CodedException.FACEBOOK_AUTH_ERROR);
        break;
      case FacebookLoginStatus.loggedIn:
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookLoginResult.accessToken.token);
        FirebaseUser user =
            await _firebaseAuth.signInWithCredential(authCredential);
        return user;
        break;
      default:
        throw CodedException();
    }
  }

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;
      AuthCredential authCredential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      FirebaseUser user =
          await _firebaseAuth.signInWithCredential(authCredential);
      return user;
    } catch (e) {
      print(e);
      throw CodedException(code: CodedException.GOOGLE_AUTH_ERROR);
    }
  }

  Future<FirebaseUser> emailSignIn(
      {@required String email, @required String password}) async {
    try {
      FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      print(e);
      throw CodedException(code: CodedException.EMAIL_AUTH_ERROR);
    }
  }

  Future<bool> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      throw CodedException(code: CodedException.LOGOUT_AUTH_ERROR);
    }
  }
}
