import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String province;
  final String city;
  final String profileImage;
  final String ktp;
  final bool active;
  final bool complete;
  final bool verified;

  String get fullName => "$firstName $lastName";

  User(
      {this.email,
      this.firstName,
      this.lastName,
      this.address,
      this.province,
      this.city,
      this.profileImage,
      this.ktp,
      this.active,
      this.complete,
      this.verified})
      : super([
          email,
          firstName,
          lastName,
          address,
          profileImage,
          province,
          city,
          ktp,
          active,
          complete,
          verified
        ]);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map["email"],
      firstName: map["first_name"],
      lastName: map["last_name"],
      address: map["address"],
      profileImage: map["profile_image"],
      province: map["province"],
      city: map["city"],
      ktp: map["ktp"],
      active: map["active"],
      complete: map["complete"],
      verified: map["verified"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": this.email,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "address": this.address,
      "profile_image": this.profileImage,
      "province": this.province,
      "city": this.city,
      "ktp": this.ktp,
      "active": this.active,
      "complete": this.complete,
      "verified": this.verified,
    };
  }
}
