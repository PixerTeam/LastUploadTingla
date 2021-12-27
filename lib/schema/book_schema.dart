const String savedTable = 'saved_books';

class SavedTableFields {
  static const bookId = 'id';
  static const title = 'title';
  static const description = 'description';
  static const price = 'price';
  static const authorName = 'author_name';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const bookPhoto = 'book_photo';
  static const subsCount = 'subs_count';
  static const rating = 'rating';
}

class SavedBook {
  final String? id;
  final String? title;
  final String? description;
  final String? authorName;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bookPhoto;
  final int? subsCount;
  final int? rating;

  SavedBook({
    this.id,
    this.title,
    this.description,
    this.authorName,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.bookPhoto,
    this.subsCount,
    this.rating,
  });

  factory SavedBook.fromDatabase(Map<String, dynamic> json) => SavedBook(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        authorName: json['author_name'],
        price: json['price'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        bookPhoto: json['book_photo'],
        subsCount: json['subs_count'],
        rating: json['rating'],
      );

  Map<String, dynamic> toDatabase() => {
        SavedTableFields.bookId: id,
        SavedTableFields.title: title,
        SavedTableFields.description: description,
        SavedTableFields.authorName: authorName,
        SavedTableFields.price: price,
        SavedTableFields.createdAt: createdAt.toString(),
        SavedTableFields.updatedAt: updatedAt.toString(),
        SavedTableFields.bookPhoto: bookPhoto,
        SavedTableFields.subsCount: subsCount,
        SavedTableFields.rating: rating,
      };
}

class Book {
  Book({
    this.ok,
    this.data,
    this.subsCount,
    this.rating,
    this.isSubscribed,
    this.userRate,
  });

  bool? ok;
  Data? data;
  int? subsCount;
  int? rating;
  bool? isSubscribed;
  UserRate? userRate;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        ok: json["ok"],
        data: Data?.fromJson(json["data"], json["is_subscribed"]),
        subsCount: json["subs_count"],
        rating: json["rating"],
        isSubscribed: json["is_subscribed"],
        userRate: json["user_rate"] != null ? UserRate.fromJson(json["user_rate"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "data": data!.toJson(),
        "subs_count": subsCount,
        "rating": rating,
        "is_subscribed": isSubscribed,
      };
}

class Data {
  Data({
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
    this.author,
    this.bookPhoto,
    this.heads,
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
  Category? category;
  String? bookPhoto;
  Author? author;
  List<Head>? heads;

  factory Data.fromJson(Map<String, dynamic> json, bool subcription) {
    String? imageUrl;
    if (json["book_photo"] != null) {
      BookPhoto bookPhoto = BookPhoto.fromJson(json["book_photo"]);

      imageUrl =
          'https://tingla.pixer.uz/books/covers/${bookPhoto.bookFile!.photoId}.${bookPhoto.bookFile!.type}';
    }

    return Data(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      media: json["media"],
      mediaType: json["media_type"],
      createdAt: DateTime?.parse(json["createdAt"]),
      updatedAt: DateTime?.parse(json["updatedAt"]),
      categoryId: json["category_id"],
      author: Author.fromJson(json["author"]),
      category: Category.fromJson(json["category"]),
      bookPhoto: imageUrl,
      heads: subcription
          ? List<Head>.from(json["heads"].map((x) => Head.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "author": author!.toJson(),
        "price": price,
        "media": media,
        "media_type": mediaType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category_id": categoryId,
        "category": category!.toJson(),
        "book_photo": bookPhoto!,
        "heads": List<dynamic>.from(heads!.map((x) => x.toJson())),
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
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Head {
  Head({
    this.headId,
    this.title,
    this.body,
    this.audio,
    this.createdAt,
    this.updatedAt,
    this.bookId,
  });

  String? headId;
  String? title;
  String? body;
  String? audio;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookId;

  factory Head.fromJson(Map<String, dynamic> json) => Head(
        headId: json["head_id"],
        title: json["title"],
        body: json["body"],
        audio: json["audio"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        bookId: json["book_id"],
      );

  Map<String, dynamic> toJson() => {
        "head_id": headId,
        "title": title,
        "body": body,
        "audio": audio,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "book_id": bookId,
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

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        audioId: json["audio_id"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
        headId: json["head_id"],
        audioFile: AudioFile.fromJson(json["audio_file"]),
      );

  Map<String, dynamic> toJson() => {
        "audio_id": audioId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "head_id": headId,
        "audio_file": audioFile!.toJson(),
      };
}

class AudioFile {
  AudioFile({
    this.fileId,
    this.type,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String? fileId;
  String? type;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        fileId: json["file_id"],
        type: json["type"],
        name: json["name"],
        createdAt: DateTime?.parse(json["createdAt"]),
        updatedAt: DateTime?.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "type": type,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class UserRate {
  UserRate({
    this.rating,
  });

  int? rating;

  factory UserRate.fromJson(Map<String, dynamic> json) => UserRate(
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
      };
}
