class AuthorBook {
  AuthorBook({
    this.author,
    this.id,
    this.title,
    this.description,
    this.price,
    this.media,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.authorId,
    this.category,
    this.bookPhoto,
  });

  Author? author;
  String? id;
  String? title;
  String? description;
  String? price;
  String? media;
  String? mediaType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  String? authorId;
  Category? category;
  String? bookPhoto;

  factory AuthorBook.fromJson(Map<String, dynamic> json, Map<String, dynamic> author) {
    String? imageUrl;

    if (json["book_photo"] != null) {
      BookPhoto bookPhoto = BookPhoto.fromJson(json["book_photo"]);

      imageUrl =
          'https://tingla.pixer.uz/books/covers/${bookPhoto.bookFile!.photoId}.${bookPhoto.bookFile!.type}';
    }

    return AuthorBook(
      author: Author.fromJson(author),
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      media: json["media"],
      mediaType: json["media_type"],
      createdAt: DateTime?.parse(json["createdAt"]),
      updatedAt: DateTime?.parse(json["updatedAt"]),
      categoryId: json["category_id"],
      authorId: json["author_id"],
      category: Category.fromJson(json["category"]),
      bookPhoto: imageUrl,
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
        "author_id": authorId,
        "category": category!.toJson(),
        "book_photo": bookPhoto,
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
