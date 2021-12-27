// To parse this JSON data, do
//
//     final oneCategory = oneCategoryFromJson(jsonString);

import 'dart:convert';

OneCategory oneCategoryFromJson(String str) =>
    OneCategory.fromJson(json.decode(str));

String oneCategoryToJson(OneCategory data) => json.encode(data.toJson());

class OneCategory {
  OneCategory({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.books,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Book>? books;

  factory OneCategory.fromJson(Map<String, dynamic> json) => OneCategory(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "books": List<dynamic>.from(books!.map((x) => x.toJson())),
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
    this.bookPhoto,
    this.author,
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
  String? bookPhoto;
  Author? author;

  factory Book.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json["book_photo"] != null) {
      BookPhoto bookPhoto = BookPhoto.fromJson(json["book_photo"]);

      imageUrl =
          'https://tingla.pixer.uz/books/covers/${bookPhoto.bookFile!.photoId}.${bookPhoto.bookFile!.type}';
    }

    return Book(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      media: json["media"],
      mediaType: json["media_type"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      categoryId: json["category_id"],
      bookPhoto: imageUrl,
      author: Author.fromJson(json["author"]),
    );
  }

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
        "book_photo": bookPhoto!,
        "author": author!.toJson(),
      };
}

class BookPhoto {
  BookPhoto({
    this.photoId,
    this.createdAt,
    this.updatedAt,
    this.bookId,
    this.fileId,
    this.bookFile,
  });

  String? photoId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;
  String? fileId;
  BookFile? bookFile;

  factory BookPhoto.fromJson(Map<String, dynamic> json) => BookPhoto(
        photoId: json["photo_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookId: json["book_id"],
        fileId: json["file_id"],
        bookFile: BookFile.fromJson(json["book_file"]),
      );

  Map<String, dynamic> toJson() => {
        "photo_id": photoId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
        "file_id": fileId,
        "book_file": bookFile!.toJson(),
      };
}

class BookFile {
  BookFile({
    this.photoId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.bookId,
  });

  String? photoId;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;

  factory BookFile.fromJson(Map<String, dynamic> json) => BookFile(
        photoId: json["photo_id"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookId: json["book_id"],
      );

  Map<String, dynamic> toJson() => {
        "photo_id": photoId,
        "type": type,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
      };
}


class Author {
    Author({
        this.authorId,
        this.authorName,
        this.createdAt,
        this.updatedAt,
        this.booksCount,
    });

    String? authorId;
    String? authorName;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? booksCount;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorId: json["author_id"],
        authorName: json["author_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        booksCount: json["books_count"],
    );

    Map<String, dynamic> toJson() => {
        "author_id": authorId,
        "author_name": authorName,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "books_count": booksCount,
    };
}

