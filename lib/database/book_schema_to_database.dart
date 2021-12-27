import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tingla/variables/variables.dart';
import 'package:path/path.dart' as path;

const String bookTable = 'books';

class BookTableFields {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const authorName = 'author_name';
  static const price = 'price';
  static const media = 'media';
  static const mediaType = 'media_type';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const categoryId = 'category_id';
  static const rating = 'rating';
  static const bookPhoto = 'book_photo';
}

class Book {
  Book({
    this.id,
    this.title,
    this.description,
    this.authorName,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.rating,
    this.bookPhoto,
  });

  String? id;
  String? title;
  String? description;
  String? authorName;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  int? rating;
  String? bookPhoto;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["data"]["id"],
        title: json["data"]["title"],
        description: json["data"]["description"],
        authorName: json["data"]["author"]["author_name"],
        price: json["data"]["price"],
        createdAt: DateTime.parse(json["data"]["createdAt"]),
        updatedAt: DateTime.parse(json["data"]["updatedAt"]),
        categoryId: json["data"]["category_id"],
        rating: json["rating"],
        bookPhoto: json["data"]["book_photo"],
      );

  factory Book.fromDatabase(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        authorName: json["author_name"],
        price: json["media_type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        categoryId: json["category_id"],
        rating: json["rating"],
        bookPhoto: json["book_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "author_name": authorName,
        "price": price,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "category_id": categoryId,
        "rating": rating,
        "book_photo": bookPhoto,
      };
}

class BookPhoto {
  BookPhoto({
    this.fileId,
    this.bookFile,
  });

  String? fileId;
  BookFile? bookFile;

  factory BookPhoto.fromJson(Map<String, dynamic> json) => BookPhoto(
        fileId: json["file_id"],
        bookFile: BookFile.fromJson(json["book_file"]),
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "book_file": bookFile!.toJson(),
      };
}

class BookFile {
  BookFile({
    this.photoId,
    this.type,
  });

  String? photoId;
  String? type;

  factory BookFile.fromJson(Map<String, dynamic> json) => BookFile(
        photoId: json["photo_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "photo_id": photoId,
        "type": type,
      };
}

const String headTable = 'heads';

class HeadTableFields {
  static const headId = 'head_id';
  static const title = 'title';
  static const body = 'body';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const bookId = 'book_id';
}

class Head {
  Head({
    this.headId,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.bookId,
  });

  String? headId;
  String? title;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;

  factory Head.fromJson(Map<String, dynamic> json) => Head(
        headId: json["head_id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookId: json["book_id"],
      );

  Map<String, dynamic> toJson() => {
        "head_id": headId,
        "title": title,
        "body": body,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
      };
}

const String audioTable = 'audios';

class AudioTableFields {
  static const audioId = 'audio_id';
  static const updatedAt = 'updatedAt';
  static const createdAt = 'createdAt';
  static const headId = 'head_id';
  static const fileId = 'file_id';
  static const type = 'type';
  static const name = 'name';
  static const duration = 'duration';
  static const audio = 'audio';
}

class Audio {
  Audio({
    this.audioId,
    this.createdAt,
    this.updatedAt,
    this.headId,
    this.audioFile,
    this.audio,
  });

  String? audioId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? headId;
  AudioFile? audioFile;
  String? audio;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        audioId: json["audio_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        headId: json["head_id"],
        audioFile: AudioFile.fromJson(json["audio_file"]),
      );

  factory Audio.fromDatabase(Map<String, dynamic> json) => Audio(
        audioId: json["audio_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        headId: json["head_id"],
        audioFile: AudioFile(
          fileId: json["file_id"],
          type: json["type"],
          name: json["name"],
          duration: json["duration"],
          createdAt: DateTime.parse(json["createdAt"]),
          updatedAt: DateTime.parse(json["updatedAt"]),
        ),
        audio: json["audio"],
      );

  Future<Map<String, dynamic>> toJson() async {
    String? _audioPath;
    if (audioFile != null) {
      String _audioUrl =
          'https://tingla.pixer.uz/audio/${audioFile!.fileId}.${audioFile!.type}?ssid=${Variables.userToken}';

      http.Response response = await http.get(Uri.parse(_audioUrl));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        Directory directory = await getApplicationDocumentsDirectory();
        String audioPath = '${directory.path}/audios/';
        bool audioDirectoryIsExists = await Directory(audioPath).exists();

        if (!audioDirectoryIsExists) {
          await Directory(audioPath).create();
        }

        File audio = File(path.join(audioPath, '$audioId.mp3'));

        audio.writeAsBytesSync(bytes);
        _audioPath = audio.path;
      } else {
        throw Exception("FAIL LOAD AUDIO FILE ...");
      }
    }

    return {
      "audio_id": audioId,
      "createdAt": createdAt!.toIso8601String(),
      "updatedAt": updatedAt!.toIso8601String(),
      "head_id": headId,
      "file_id": audioFile!.fileId,
      "type": audioFile!.type,
      "name": audioFile!.name,
      "duration": audioFile!.duration,
      "audio": _audioPath,
    };
  }
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
  int? duration;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        fileId: json["file_id"],
        type: json["type"],
        name: json["name"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
