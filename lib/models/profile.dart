import 'package:dating_made_better/constants.dart';

class MiniProfile {
  final int id;
  final String name;
  final int? age;
  final bool? photoVerified;
  final String? photo;
  final Gender? gender;

  MiniProfile(
      {required this.id,
      required this.name,
      this.age,
      this.photoVerified,
      this.photo,
      this.gender});

  static fromJson(profile) {
    return MiniProfile(
      id: profile["id"],
      name: profile["name"],
      age: profile["age"] ?? 22,
      gender: Gender.values[profile["gender"]],
      photoVerified: profile["photo_verified"],
      photo: profile["photo"],
    );
  }
}
