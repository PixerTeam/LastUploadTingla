import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tingla/schema/book_schema.dart' as book;
import 'package:tingla/schema/cache_book_schema.dart' as bookCache;
import 'package:tingla/schema/profile_data_schema.dart' as profile;

import 'book_schema_to_database.dart' as bookSchema;

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static String? path;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // initilize database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, _databaseName);

    //

    return await openDatabase(path!,
        version: _databaseVersion, onCreate: _onCreateTables);
  }

  // SQL code to create the database table
  Future _onCreateTables(Database db, int version) async {
    await _createProfileTable(db);
    await _createSavedTable(db);
    await _createBooksTable(db);
    await _createHeadsTable(db);
    await _createAudiosTable(db);
    await _createSearchHistory(db);
    await _createCacheTable(db);
  }

  // ----------------------------------- CREATE TABLE COMMANDS ---------------------------------
  // saved table
  Future<void> _createSavedTable(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS ${book.savedTable} (
            book_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${book.SavedTableFields.bookId} TEXT NOT NULL,
            ${book.SavedTableFields.title} TEXT NOT NULL,
            ${book.SavedTableFields.description} TEXT NOT NULL,
            ${book.SavedTableFields.authorName} TEXT NOT NULL,
            ${book.SavedTableFields.price} INTEGER NOT NULL,
            ${book.SavedTableFields.createdAt} TEXT NOT NULL,
            ${book.SavedTableFields.updatedAt} TEXT NOT NULL,
            ${book.SavedTableFields.bookPhoto} TEXT
          )
          ''';

    await db.execute(cmd);
  }

  // profile table
  Future<void> _createProfileTable(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS ${profile.profileTable} (
            ${profile.ProfileTableFields.profileId} TEXT NOT NULL,
            ${profile.ProfileTableFields.profileName} TEXT NOT NULL,
            ${profile.ProfileTableFields.profileEmail} TEXT,
            ${profile.ProfileTableFields.profilePhone} TEXT NOT NULL,
            ${profile.ProfileTableFields.profileRole} TEXT NOT NULL,
            ${profile.ProfileTableFields.profileBirthDate} TEXT,
            ${profile.ProfileTableFields.profileGender} INTEGER,
            ${profile.ProfileTableFields.profileAttempts} INTEGER NOT NULL,
            ${profile.ProfileTableFields.profileCreatedAt} TEXT NOT NULL,
            ${profile.ProfileTableFields.profileUpdateAt} TEXT NOT NULL,
            ${profile.ProfileTableFields.profilePhoto} TEXT
          )
          ''';

    await db.execute(cmd);
  }

  // downloaded books table
  Future<void> _createBooksTable(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS ${bookSchema.bookTable} (
            ${bookSchema.BookTableFields.id} TEXT NOT NULL,
            ${bookSchema.BookTableFields.title} TEXT NOT NULL,
            ${bookSchema.BookTableFields.description} TEXT NOT NULL,
            ${bookSchema.BookTableFields.authorName} TEXT NOT NULL,
            ${bookSchema.BookTableFields.price} TEXT NOT NULL,
            ${bookSchema.BookTableFields.createdAt} TEXT NOT NULL,
            ${bookSchema.BookTableFields.updatedAt} TEXT NOT NULL,
            ${bookSchema.BookTableFields.categoryId} TEXT NOT NULL,
            ${bookSchema.BookTableFields.rating} INTEGER NOT NULL,
            ${bookSchema.BookTableFields.bookPhoto} TEXT
          )
          ''';

    await db.execute(cmd);
  }

  // downloaded heads table
  Future<void> _createHeadsTable(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS ${bookSchema.headTable} (
            ${bookSchema.HeadTableFields.headId} TEXT NOT NULL,
            ${bookSchema.HeadTableFields.title} TEXT NOT NULL,
            ${bookSchema.HeadTableFields.body} TEXT,
            ${bookSchema.HeadTableFields.createdAt} TEXT NOT NULL,
            ${bookSchema.HeadTableFields.updatedAt} TEXT NOT NULL,
            ${bookSchema.HeadTableFields.bookId} TEXT NOT NULL
          )
          ''';

    await db.execute(cmd);
  }

  // downloaded audios table
  Future<void> _createAudiosTable(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS ${bookSchema.audioTable} (
            ${bookSchema.AudioTableFields.audioId} TEXT NOT NULL,
            ${bookSchema.AudioTableFields.createdAt} TEXT,
            ${bookSchema.AudioTableFields.updatedAt} TEXT,
            ${bookSchema.AudioTableFields.headId} TEXT NOT NULL,
            ${bookSchema.AudioTableFields.fileId} TEXT NOT NULL,
            ${bookSchema.AudioTableFields.type} TEXT NOT NULL,
            ${bookSchema.AudioTableFields.name} TEXT NOT NULL,
            ${bookSchema.AudioTableFields.duration} INTEGER NOT NULL,
            ${bookSchema.AudioTableFields.audio} TEXT
          )
          ''';

    await db.execute(cmd);
  }

  // search history table
  Future<void> _createSearchHistory(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS search_history (
            item TEXT NOT NULL PRIMARY KEY
          )
          ''';

    await db.execute(cmd);
  }

  // cache book table
  Future<void> _createCacheTable(Database db) async {
    String cmd = '''
          CREATE TABLE IF NOT EXISTS ${bookCache.cacheTable} (
            ${bookCache.CacheBookFields.bookId} TEXT NOT NULL PRIMARY KEY,
            ${bookCache.CacheBookFields.headIndex} INTEGER NOT NULL,
            ${bookCache.CacheBookFields.headCurrentOffset} REAL NOT NULL,
            ${bookCache.CacheBookFields.headMaxOffset} REAL NOT NULL,
            ${bookCache.CacheBookFields.audioCurrentOffset} INTEGER NOT NULL,
            ${bookCache.CacheBookFields.audioMaxOffset} INTEGER NOT NULL
          )
          ''';

    await db.execute(cmd);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(dynamic data, {required table}) async {
    Database db = await instance.database;
    int result = 0;

    if (table == "saved") {
      dynamic _bookData = data;

      Map<String, dynamic> _dataMap = {
        book.SavedTableFields.bookId: _bookData.id,
        book.SavedTableFields.title: _bookData.title,
        book.SavedTableFields.description: _bookData.description,
        book.SavedTableFields.authorName: _bookData.author.authorName,
        book.SavedTableFields.price: int.parse(_bookData.price.toString()),
        book.SavedTableFields.createdAt: _bookData.createdAt.toString(),
        book.SavedTableFields.updatedAt: _bookData.createdAt.toString(),
        book.SavedTableFields.bookPhoto: _bookData.bookPhoto,
      };

      result = await db.insert(book.savedTable, _dataMap);
    } else if (table == "profile") {
      result = await db.insert(profile.profileTable, await data.data!.toJson());
    } else if (table == "history") {
      result = await db.insert("search_history", {'item': data});
    } else if (table == "cache") {
      result = await db.insert(bookCache.cacheTable, data.toDatabase());
    }

    return result;
  }

  // for insert book to database (download)
  Future<int> downloadBook(bookSchema.Book book) async {
    Database db = await instance.database;

    var newBook = book.toJson();
    int result = await db.insert(bookSchema.bookTable, newBook);

    return result;
  }

  // for head audio to database (download)
  Future<int> downloadHead(bookSchema.Head head) async {
    Database db = await instance.database;
    int result = await db.insert(bookSchema.headTable, head.toJson());

    return result;
  }

  // for insert audio to database (download)
  Future<int> downloadAudio(bookSchema.Audio audio) async {
    Database db = await instance.database;
    var newAudio = await audio.toJson();
    int result = await db.insert(bookSchema.audioTable, newAudio);

    return result;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future queryAllRows({required table, id}) async {
    Database db = await instance.database;
    dynamic result;

    if (table == 'saved') {
      result = await db.query(book.savedTable);
    } else if (table == 'profile') {
      result = await db.query(profile.profileTable);
    } else if (table == 'book') {
      result = await db.query(bookSchema.bookTable);
    } else if (table == 'audio') {
      result = await db.query(bookSchema.audioTable);
    } else if (table == 'head') {
      result = await db.query(bookSchema.headTable);
    } else if (table == 'history') {
      result = await db.query('search_history');
    } else if (table == 'cache') {
      result = await db.query(bookCache.cacheTable);
    }

    //

    return result;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(id, {required table}) async {
    Database db = await instance.database;
    int result = 0;
    if (table == 'saved') {
      result =
          await db.delete(book.savedTable, where: 'id = ?', whereArgs: [id]);
    } else if (table == 'book') {
      result = await db.delete(bookSchema.bookTable,
          where: '${bookSchema.BookTableFields.id} = ?', whereArgs: [id]);

      if (result == 1) {
        var heads = await findQuery(id, table: "head");

        for (bookSchema.Head head in heads) {
          result = await db.delete(bookSchema.audioTable,
              where: '${bookSchema.AudioTableFields.headId} = ?',
              whereArgs: [head.headId]);

          result = await db.delete(bookSchema.headTable,
              where: '${bookSchema.HeadTableFields.headId} = ?',
              whereArgs: [head.headId]);
        }
      }
    } else if (table == 'history') {
      result =
          await db.delete('search_history', where: 'item = ?', whereArgs: [id]);
    } else if (table == 'cache') {
      result = await db.delete(bookCache.cacheTable,
          where: '${bookCache.CacheBookFields.bookId} = ?', whereArgs: [id]);
    }

    if (result == 0) {
      throw 'FAILED DATA DELETED';
    }

    return result;
  }

  // for delete table in database
  Future<int> deleteRow({required table}) async {
    Database db = await instance.database;
    int result = 0;
    if (table == 'history') {
      result = await db.delete('search_history');
    }

    return result;
  }

  // for check is exists in database
  Future<bool> isExist(String id, {required table}) async {
    Database db = await instance.database;
    var result = [];

    if (table == "profile") {
      result = await db.rawQuery(
          'SELECT * FROM ${profile.profileTable} WHERE ${profile.ProfileTableFields.profileId} ="$id"');
    } else if (table == "saved") {
      result = await db.rawQuery(
          'SELECT * FROM ${book.savedTable} WHERE ${book.SavedTableFields.bookId} ="$id"');
    } else if (table == "book") {
      result = await db.rawQuery(
          'SELECT * FROM ${bookSchema.bookTable} WHERE ${bookSchema.BookTableFields.id} ="$id"');
    } else if (table == "history") {
      result =
          await db.rawQuery('SELECT * FROM search_history WHERE item ="$id"');
    } else if (table == "head") {
      result = await db.rawQuery(
          'SELECT * FROM ${bookSchema.headTable} WHERE ${bookSchema.HeadTableFields.headId} ="$id"');
    } else if (table == "audio") {
      result = await db.rawQuery(
          'SELECT * FROM ${bookSchema.audioTable} WHERE ${bookSchema.AudioTableFields.audioId} ="$id"');
    } else if (table == "cache") {
      result = await db.rawQuery(
          'SELECT * FROM ${bookCache.cacheTable} WHERE ${bookCache.CacheBookFields.bookId} ="$id"');
    }

    //

    return result.isNotEmpty ? true : false;
  }

  // for get all data of table in database
  Future findQuery(id, {required table}) async {
    Database db = await instance.database;
    var result = [];

    if (table == "head") {
      var data = await db.rawQuery(
          'SELECT * FROM ${bookSchema.headTable} WHERE ${bookSchema.HeadTableFields.bookId} ="$id"');

      for (Map<String, dynamic> head in data) {
        result.add(bookSchema.Head.fromJson(head));
      }
    } else if (table == "book") {
      var data = await db.rawQuery(
          'SELECT * FROM ${bookSchema.bookTable} WHERE ${bookSchema.BookTableFields.id} ="$id"');

      for (Map<String, dynamic> book in data) {
        result.add(bookSchema.Book.fromDatabase(book));
      }
    } else if (table == "audio") {
      var data = await db.rawQuery(
          'SELECT * FROM ${bookSchema.audioTable} WHERE ${bookSchema.AudioTableFields.headId} = "$id"');

      for (Map<String, dynamic> audio in data) {
        result.add(bookSchema.Audio.fromDatabase(audio));
      }
    } else if (table == 'cache') {
      var data = await db.rawQuery(
          'SELECT * FROM ${bookCache.cacheTable} WHERE ${bookCache.CacheBookFields.bookId} ="$id"');

      for (Map<String, dynamic> book in data) {
        result.add(bookCache.CacheBook.fromDatabase(book));
      }
    }

    return result;
  }

  // for update data in database
  Future<int> update(dynamic data, {required table}) async {
    Database db = await instance.database;
    int reslut = 0;

    if (table == "profile") {
      profile.Data _profile = data.data!;

      reslut = await db.update(profile.profileTable, await _profile.toJson(),
          where: '${profile.ProfileTableFields.profileId} = ?',
          whereArgs: [_profile.userId]);
      //
    } else if (table == 'cache') {
      reslut = await db.update(bookCache.cacheTable, data.toDatabase(),
          where: '${bookCache.CacheBookFields.bookId} = ?',
          whereArgs: [data.bookId]);

      //
    }

    return reslut;
  }

  // for close in database
  Future<void> close() async {
    final Database db = await instance.database;
    db.close();
  }

  // for database delete
  Future deleteAllDatabase() async {
    final Database db = await instance.database;

    await db.execute("DROP TABLE IF EXISTS ${book.savedTable}");
    await db.execute("DROP TABLE IF EXISTS ${profile.profileTable}");
    await db.execute("DROP TABLE IF EXISTS ${bookSchema.bookTable}");
    await db.execute("DROP TABLE IF EXISTS ${bookSchema.headTable}");
    await db.execute("DROP TABLE IF EXISTS ${bookSchema.audioTable}");
    await db.execute("DROP TABLE IF EXISTS ${bookCache.cacheTable}");
    await db.execute("DROP TABLE IF EXISTS search_history");

    await _createProfileTable(db);
    await _createSavedTable(db);
    await _createBooksTable(db);
    await _createHeadsTable(db);
    await _createAudiosTable(db);
    await _createSearchHistory(db);
    await _createCacheTable(db);
    
  }
}
