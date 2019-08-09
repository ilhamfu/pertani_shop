import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pertani_shop/bloc/auth/data_layer/api_client.dart';
import 'package:pertani_shop/bloc/auth/data_layer/firebase_client.dart';

class AuthRepository{
  FirebaseAuthClient _fireBaseAuthClient = FirebaseAuthClient();
  AuthApiClient _authApiClient = AuthApiClient();

  Future<FirebaseUser> emailSignIn({@required String email,@required String password}) => _fireBaseAuthClient.emailSignIn(email: email,password: password);
  Future<FirebaseUser> facebookSignIn() => _fireBaseAuthClient.facebookSignIn();
  Future<FirebaseUser> googleSignIn() => _fireBaseAuthClient.googleSignIn();
}