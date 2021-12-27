// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    this.id,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.bookId,
    this.userId,
    this.user,
  });

  String? id;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;
  String? userId;
  User? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookId: json["book_id"],
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
        "user_id": userId,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.name,
    this.userPhotos,
  });

  String? name;
  List<UserPhoto>? userPhotos;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        userPhotos: List<UserPhoto>.from(
            json["user_photos"].map((x) => UserPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_photos": List<dynamic>.from(userPhotos!.map((x) => x.toJson())),
      };
}

class UserPhoto {
  UserPhoto({
    this.photoId,
    this.file,
  });

  String? photoId;
  FileClass? file;

  factory UserPhoto.fromJson(Map<String, dynamic> json) => UserPhoto(
        photoId: json["photo_id"],
        file: FileClass.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "photo_id": photoId,
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
