import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String accessToken;
  final int expiresIn;
  final String tokenType;
  final String scope;
  final String refreshToken;

  AuthResponse(
      {this.accessToken,
      this.expiresIn,
      this.tokenType,
      this.scope,
      this.refreshToken})
      : super([
          accessToken,
          expiresIn,
          tokenType,
          scope,
          refreshToken,
        ]);
  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      accessToken: map["access_token"],
      expiresIn: map["expires_in"],
      tokenType: map["token_type"],
      scope: map["scope"],
      refreshToken: map["refresh_token"],
    );
  }
}
