import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tingla/database/database_helper.dart';

import 'package:tingla/schema/best_book_schema.dart' as bestBook;
import 'package:tingla/schema/book_schema.dart' as book;
import 'package:tingla/schema/cache_book_schema.dart' as cacheBook;
import 'package:tingla/schema/category_schema.dart' as categorySchema;
import 'package:tingla/schema/one_category_schema.dart';
import 'package:tingla/schema/profile_data_schema.dart';
import 'package:tingla/database/book_schema_to_database.dart' as bookSchema;

enum DownloadState { downloaded, downloading, notDonwloaded, errorDownloading }

class Variables {
  static String? userToken;
  static SharedPreferences? prefs;
  static bool isSubcriptioned =false;

  static bool notification = true;
  static ValueNotifier<int> currentScreenIndexNotifier = ValueNotifier<int>(0);
  
  static late AudioHandler audioPlayer; 

  static late VoidCallback appScreenState;
  static late VoidCallback bottomNavigationState;

  static List<categorySchema.Category> categories = [];
  static List<OneCategory> opennedCatigories = [];
  static List<bestBook.BestBook> bestBooks = [];
  static List<book.SavedBook> savedBooks = [];
  static List<bookSchema.Book> localBooks = [];
  static Map<String, dynamic>? bookHeads;
  static Map<String, dynamic>? localBookHeads;
  static book.Book? openBook;
  static bookSchema.Book? localBook;

  // static BookControl bookControl = BookControl();
  static cacheBook.CacheBook? newCacheBook;
  static LocalProfileData? profileData;

  static double speed = 1.0;

  static File? newUserPhoto;
  static String? userPhoto;
  static String? newUserName;
  static String? newUserPhone;

  static ValueNotifier<DownloadState> downloadNotifier =
      ValueNotifier(DownloadState.notDonwloaded);

  static ValueNotifier<bool> downloadedBookNotifier =
      ValueNotifier(true);

  // reference to our single class that manages the database
  static DatabaseHelper? databaseHelper;
}
