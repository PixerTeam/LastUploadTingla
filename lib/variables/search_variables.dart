import 'package:flutter/material.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/schema/searched_book_schema.dart';
import 'package:tingla/variables/variables.dart';

enum SearchState { notSearched, searched, searching, onHistory }
enum SearchStateConnection { searching, completed, hasError }

class SearchVariables {
  static TextEditingController searchController = TextEditingController();

  static PageController? searchScreenPageController;
  static int curentSearchScreen = 0;

  static String result = "";

  static FocusNode focus = FocusNode();

  // search screen variables
  static ValueNotifier<List<String>> blackTextListNotifier =
      ValueNotifier<List<String>>([]);
  static ValueNotifier<List<String>> greyTextListNotifier =
      ValueNotifier<List<String>>([]);

  // search searching state
  static ValueNotifier<SearchStateConnection> searchStateConnectionNotifier =
      ValueNotifier<SearchStateConnection>(SearchStateConnection.completed);

  // search data list
  static ValueNotifier<List<SearchedBookSchema>> searchResultNotifier =
      ValueNotifier<List<SearchedBookSchema>>([]);

  // text for textcontroller
  static ValueNotifier<String> searchTextNotifier = ValueNotifier<String>('');

  // check for search widget active or not active
  static ValueNotifier<bool> isActiveNotifier = ValueNotifier<bool>(false);

  // change state of search
  static void searchState(SearchState state) {
    switch (state) {
      case SearchState.notSearched:
        changeScreen(0);
        isActiveNotifier.value = false;
        break;

      case SearchState.searched:
        changeScreen(3);
        break;

      case SearchState.searching:
        changeScreen(2);
        break;

      case SearchState.onHistory:
        changeScreen(1);
        break;
    }
  }

  // change body page view controller
  static void changeScreen(int index) {
    searchScreenPageController!.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );

    curentSearchScreen = index;
  }

  // get search in api
  static void searchListener() async {
    String data = searchController.text;
  }

  // for on tap to search widget
  static void onTap() {
    String data = searchController.text;
    isActiveNotifier.value = true;

    if (result.isEmpty && data.isEmpty) {
      searchState(SearchState.onHistory);
    } else if (result.isEmpty) {
      searchState(SearchState.searching);
    } else {
      searchState(SearchState.searched);
    }
  }

  // write to search widget
  static void onChanged(String text) async {
    result = '';
    searchTextNotifier.value = text;

    searchResultNotifier.value = [];

    if (result.isEmpty && text.isEmpty) {
      searchState(SearchState.onHistory);
    } else if (result.isEmpty) {
      searchState(SearchState.searching);
    } else {
      searchState(SearchState.searched);
    }

    searchStateConnectionNotifier.value = SearchStateConnection.searching;
    try {
      await searchInNetwork(text);
      searchStateConnectionNotifier.value = SearchStateConnection.completed;
    } catch (e) {
      searchStateConnectionNotifier.value = SearchStateConnection.hasError;
    }
  }

  // search widget on submitted
  static void onSubmitted(String text) {
    result = text;
    RegExp regExp = RegExp(r"^[a-zA-Z0-9]+$");

    bool notBadResult = false;

    for (String letter in result.split('')) {
      if (letter.contains(regExp)) {
        notBadResult = true;

        break;
      }
    }

    if (!notBadResult) {
      result = '';
      searchController.clear();
      searchTextNotifier.value = '';

      searchState(SearchState.notSearched);
    } else {
      searchState(SearchState.searched);

      if (result.isNotEmpty) {
        Variables.databaseHelper!
            .isExist(result, table: 'history')
            .then((value) {
          if (!value) {
            Variables.databaseHelper!.insert(
              result,
              table: 'history',
            );
          }
        });
      }
    }
  }

  static void clearText() {
    searchController.clear();
    searchTextNotifier.value = '';
    result = '';
    searchResultNotifier.value = [];

    focus.unfocus();
    searchState(SearchState.notSearched);
  }

  static void onHistory(String text) async {
    result = text;
    searchController.text = result;
    searchTextNotifier.value = text;

    searchState(SearchState.searched);

    searchController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: searchController.text.length,
      ),
    );

    if (focus.hasFocus) focus.unfocus();

    searchStateConnectionNotifier.value = SearchStateConnection.searching;
    try {
      await searchInNetwork(text);
      searchStateConnectionNotifier.value = SearchStateConnection.completed;
    } catch (e) {
      searchStateConnectionNotifier.value = SearchStateConnection.hasError;
    }
  }

  static void onSelected(SearchedBookSchema book) async {
    result = book.title!;
    searchController.text = result;
    searchTextNotifier.value = result;

    searchState(SearchState.searched);

    searchController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: searchController.text.length,
      ),
    );

    if (focus.hasFocus) focus.unfocus();

    searchResultNotifier.value = [book];

    Variables.databaseHelper!
        .isExist(
      result,
      table: 'history',
    )
        .then((value) {
      if (!value) {
        Variables.databaseHelper!.insert(
          result,
          table: 'history',
        );
      }
    });
  }

  static Future<void> searchInNetwork(String text) async {
    List<String> blackTextList = [];
    List<String> greyTextList = [];
    List<SearchedBookSchema> searchedResult = [];

    if (text.isNotEmpty) {
      List<SearchedBookSchema>? _books = await getSearchData(text);

      if (_books != null) {
        if (_books.isNotEmpty) {
          for (SearchedBookSchema _item in _books) {
            bool _find = true;
            for (var i = 0; i < text.length; i++) {
              if (_item.title![i].toLowerCase() != text[i].toLowerCase()) {
                _find = false;
                break;
              }
            }

            if (_find) {
              String _blackText = "";
              String _greyText = "";

              for (var i = 0; i < _item.title!.length; i++) {
                if (i < SearchVariables.searchController.text.length) {
                  _blackText += _item.title![i];
                } else {
                  _greyText += _item.title![i];
                }
              }

              blackTextList.add(_blackText);
              greyTextList.add(_greyText);

              searchedResult.add(_item);
            }
          }
        }
      }
    }
    SearchVariables.blackTextListNotifier.value = blackTextList;
    SearchVariables.greyTextListNotifier.value = greyTextList;
    SearchVariables.searchResultNotifier.value = searchedResult;
  }
}
