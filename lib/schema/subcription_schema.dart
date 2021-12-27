// To parse this JSON data, do
//
//     final subcription = subcriptionFromJson(jsonString);

import 'dart:convert';

Subcription subcriptionFromJson(String str) =>
    Subcription.fromJson(json.decode(str));

String subcriptionToJson(Subcription data) => json.encode(data.toJson());

class Subcription {
  Subcription({
    this.paymentId,
    this.paymentStatus,
    this.paymentBillId,
    this.paymentPayUrl,
    this.createdAt,
    this.updatedAt,
    this.bookId,
    this.userId,
    this.user,
    this.book,
  });

  String? paymentId;
  String? paymentStatus;
  int? paymentBillId;
  String? paymentPayUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;
  String? userId;
  User? user;
  Book? book;

  factory Subcription.fromJson(Map<String, dynamic> json) => Subcription(
        paymentId: json["payment_id"],
        paymentStatus: json["payment_status"],
        paymentBillId: json["payment_bill_id"],
        paymentPayUrl: json["payment_pay_url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookId: json["book_id"],
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
        book: Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "payment_status": paymentStatus,
        "payment_bill_id": paymentBillId,
        "payment_pay_url": paymentPayUrl,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
        "user_id": userId,
        "user": user!.toJson(),
        "book": book!.toJson(),
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
    this.category,
    this.bookPhoto,
    this.author,
  });

  String? id;
  String? title;
  String? description;
  String? price;
  dynamic media;
  String? mediaType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  Category? category;
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
      category: Category.fromJson(json["category"]),
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
        "category": category!.toJson(),
        "book_photo": bookPhoto,
        "author": author!.toJson(),
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

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        userAttempts: json["user_attempts"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "birth_date": birthDate,
        "gender": gender,
        "user_attempts": userAttempts,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
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
