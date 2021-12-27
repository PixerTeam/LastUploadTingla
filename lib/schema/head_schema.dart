// To parse this JSON data, do
//
//     final quran = quranFromJson(jsonString);

import 'dart:convert';

HeadSchema headSchemaFromJson(String? str) =>
    HeadSchema.fromJson(json.decode(str!));

String? quranToJson(HeadSchema data) => json.encode(data.toJson());

class HeadSchema {
  HeadSchema({
    this.headId,
    this.title,
    this.body,
    this.audio,
    this.createdAt,
    this.updatedAt,
    this.bookId,
    this.book,
    this.audios,
  });

  String? headId;
  String? title;
  String? body;
  String? audio;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;
  Book? book;
  List<Audio>? audios;

  factory HeadSchema.fromJson(Map<String?, dynamic> json) => HeadSchema(
        headId: json["head_id"],
        title: json["title"],
        body: json["body"],
        audio: json["audio"],
        createdAt: DateTime.parse(json["createdAt"].toString()),
        updatedAt: DateTime.parse(json["updatedAt"].toString()),
        bookId: json["book_id"],
        book: Book.fromJson(json["book"]),
        audios: List<Audio>.from(json["audios"].map((x) => Audio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "head_id": headId,
        "title": title,
        "body": body,
        "audio": audio,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
        "book": book!.toJson(),
        "audios": List<dynamic>.from(audios!.map((x) => x.toJson())),
      };
}

class Audio {
  Audio({
    this.audioId,
    this.createdAt,
    this.updatedAt,
    this.headId,
    this.audioFile,
  });

  String? audioId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? headId;
  AudioFile? audioFile;

  factory Audio.fromJson(Map<String?, dynamic> json) => Audio(
        audioId: json["audio_id"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        headId: json["head_id"],
        audioFile: AudioFile.fromJson(json["audio_file"]),
      );

  Map<String, dynamic> toJson() => {
        "audio_id": audioId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "head_id": headId,
        "audio_file": audioFile!.toJson(),
      };
}

class AudioFile {
  AudioFile({
    this.fileId,
    this.type,
    this.name,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  String? fileId;
  String? type;
  String? name;
  dynamic duration;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AudioFile.fromJson(Map<String, dynamic> json) {
    Duration duration = Duration.zero;

    if (json["duration"] != null) {
      int doubleDuration = double.parse(json["duration"]).round();
      duration = Duration(minutes: doubleDuration ~/ 60, seconds: (doubleDuration % 60));
    }

    return AudioFile(
      fileId: json["file_id"],
      type: json["type"],
      name: json["name"],
      duration: duration.inSeconds,
      createdAt: DateTime?.parse(json["createdAt"]),
      updatedAt: DateTime?.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "type": type,
        "name": name,
        "duration": duration,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Book {
  Book({
    this.id,
    this.title,
    this.description,
    this.price,
    this.media,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    // this.category,
  });

  String? id;
  String? title;
  String? description;
  String? price;
  String? media;
  String? mediaType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  // Category? category;

  factory Book.fromJson(Map<String?, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        media: json["media"],
        mediaType: json["media_type"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        categoryId: json["category_id"],
        // category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "media": media,
        "media_type": mediaType,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "category_id": categoryId,
        // "category": category!.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
