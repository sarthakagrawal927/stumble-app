import 'package:dating_made_better/constants.dart';

class MiniProfile {
  final int id;
  final String name;
  final int? age;
  final int? photoVerificationStatus;
  final String? photo;
  final Gender? gender;

  MiniProfile(
      {required this.id,
      required this.name,
      this.age,
      this.photoVerificationStatus,
      this.photo,
      this.gender});

  static fromJson(profile) {
    return MiniProfile(
      id: profile["id"],
      name: profile["name"],
      age: profile["age"] ?? 22,
      gender: Gender.values[profile["gender"]],
      photoVerificationStatus: profile["photo_verification_status"],
      photo: profile["photo"],
    );
  }
}
