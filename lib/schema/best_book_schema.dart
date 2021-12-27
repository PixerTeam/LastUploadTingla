// To parse this JSON data, do
//
//     final bestBook = bestBookFromJson(jsonString);

import 'dart:convert';

BestBook bestBookFromJson(String str) => BestBook.fromJson(json.decode(str));

String bestBookToJson(BestBook data) => json.encode(data.toJson());

class BestBook {
  BestBook({
    this.id,
    this.title,
    this.description,
    this.price,
    this.mediaType,
    this.createdAt,
    this.categoryId,
    this.category,
    this.bookPhoto,
    this.subscriptions,
    this.author,
  });

  String? id;
  String? title;
  String? description;
  String? price;
  String? mediaType;
  DateTime? createdAt;
  String? categoryId;
  Category? category;
  String? bookPhoto;
  int? subscriptions;
  Author? author;

  factory BestBook.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json["book_photo"] != null) {
      BookPhoto bookPhoto = BookPhoto.fromJson(json["book_photo"]);

      imageUrl =
          'https://tingla.pixer.uz/books/covers/${bookPhoto.bookFile!.photoId}.${bookPhoto.bookFile!.type}';
    }

    return BestBook(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      mediaType: json["media_type"],
      createdAt: DateTime.parse(json["created_at"]),
      categoryId: json["category_id"],
      category: Category.fromJson(json["category"]),
      bookPhoto: imageUrl,
      subscriptions: json["subscriptions"],
      author: Author.fromJson(json["author"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "media_type": mediaType,
        "created_at": createdAt!.toIso8601String(),
        "category_id": categoryId,
        "category": category!.toJson(),
        "book_photo": bookPhoto,
        "subscriptions": subscriptions,
        "author": author!.toJson(),
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Author {
  Author({
    this.authorId,
    this.authorName,
    this.createdAt,
    this.updatedAt,
  });

  String? authorId;
  String? authorName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorId: json["author_id"],
        authorName: json["author_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "author_id": authorId,
        "author_name": authorName,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
