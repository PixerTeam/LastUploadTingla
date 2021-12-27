import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:tingla/variables/variables.dart';

const String profileTable = 'profile';

class ProfileTableFields {
  static const profileId = 'user_id';
  static const profileName = 'name';
  static const profileEmail = 'email';
  static const profilePhone = 'phone';
  static const profileRole = 'role';
  static const profileBirthDate = 'birth_date';
  static const profileGender = 'gender';
  static const profileAttempts = 'user_attempts';
  static const profileCreatedAt = 'createdAt';
  static const profileUpdateAt = 'updatedAt';
  static const profilePhoto = 'user_photo';
}

// FOR LOACAL DATA
class LocalProfileData {
  LocalProfileData({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.birthDate,
    this.gender,
    this.userAttempts,
    this.createdAt,
    this.updatedAt,
    // this.subscriptions,
    this.userPhoto,
  });

  String? userId;
  String? name;
  dynamic email;
  String? phone;
  String? role;
  dynamic birthDate;
  dynamic gender;
  int? userAttempts;
  DateTime? createdAt;
  DateTime? updatedAt;
  // List<Subscription>? subscriptions;
  String? userPhoto;

  factory LocalProfileData.fromJson(Map<String?, dynamic> json) =>
      LocalProfileData(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        userAttempts: json["user_attempts"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        // subscriptions: List<Subscription>.from(json["payments"].map((x) => Subscription.fromJson(x))),
        userPhoto: json["user_photo"],
      );
}

// ------------------------------------------------------------------------------------------------------------------------ >

// FOR NETWORK GET DATA
class ProfileData {
  ProfileData({
    this.ok,
    this.data,
  });

  bool? ok;
  Data? data;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        ok: json["ok"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.birthDate,
    this.gender,
    this.userAttempts,
    this.createdAt,
    this.updatedAt,
    this.subscriptions,
    this.userPhotos,
  });

  String? userId;
  String? name;
  dynamic email;
  String? phone;
  String? role;
  dynamic birthDate;
  dynamic gender;
  int? userAttempts;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Subscription>? subscriptions;
  List<UserPhoto>? userPhotos;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        userAttempts: json["user_attempts"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        subscriptions: List<Subscription>.from(
            json["payments"].map((x) => Subscription.fromJson(x))),
        userPhotos: List<UserPhoto>.from(
            json["user_photos"].map((x) => UserPhoto.fromJson(x))),
      );

  Future<Map<String, Object?>> toJson() async {
    String? imageUrl;
    if (userPhotos!.isNotEmpty) {
      imageUrl =
          'https://tingla.pixer.uz/users/photo/${userPhotos![0].file!.photoId}.${userPhotos![0].file!.type}';
    }

    return {
      ProfileTableFields.profileId: userId,
      ProfileTableFields.profileName: name,
      ProfileTableFields.profileEmail: email,
      ProfileTableFields.profilePhone: phone,
      ProfileTableFields.profileRole: role,
      ProfileTableFields.profileBirthDate: birthDate,
      ProfileTableFields.profileGender: gender,
      ProfileTableFields.profileAttempts: userAttempts,
      ProfileTableFields.profileCreatedAt:
          createdAt!.toIso8601String().toString(),
      ProfileTableFields.profileUpdateAt:
          updatedAt!.toIso8601String().toString(),
      ProfileTableFields.profilePhoto: imageUrl,
    };
  }
}

class Subscription {
  Subscription({
    this.subscriptionId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.bookId,
  });

  String? subscriptionId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? bookId;

  factory Subscription.fromJson(Map<String?, dynamic> json) => Subscription(
        subscriptionId: json["subscription_id"],
        status: json["status"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        userId: json["user_id"],
        bookId: json["book_id"],
      );

  Map<String?, dynamic> toJson() => {
        "subscription_id": subscriptionId,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "user_id": userId,
        "book_id": bookId,
      };
}

class UserPhoto {
  UserPhoto({
    this.photoId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.fileId,
    this.file,
  });

  String? photoId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? fileId;
  FileClass? file;

  factory UserPhoto.fromJson(Map<String, dynamic> json) => UserPhoto(
        photoId: json["photo_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["user_id"],
        fileId: json["file_id"],
        file: FileClass.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "photo_id": photoId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "user_id": userId,
        "file_id": fileId,
        "file": file!.toJson(),
      };
}

class FileClass {
  FileClass({
    this.photoId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  String? photoId;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        photoId: json["photo_id"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "photo_id": photoId,
        "type": type,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "user_id": userId,
      };
}
