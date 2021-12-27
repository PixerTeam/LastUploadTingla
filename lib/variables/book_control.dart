import 'package:flutter/material.dart';
import 'package:tingla/schema/cache_book_schema.dart';

class BookControlState {
  BookControlState({
    required this.current,
    required this.total,
  });
  final double current;
  final double total;
}

class BookControl {
  BookControl() {
    _init();
  }

  double oldPosition = 0;

  ValueNotifier<bool> scrolNotifier = ValueNotifier<bool>(true);
  bool isSlider = false;

  ValueNotifier<BookControlState> progressNotifier =
      ValueNotifier<BookControlState>(
    BookControlState(current: 0.0, total: 0.0),
  );

  ScrollController? scrollController;

  void _init() {
    scrollController = ScrollController();
    scrollController!.addListener(scrolListener);
  }

  void scrolListener() {
    progressNotifier.value = BookControlState(
      current: scrollController!.offset,
      total: scrollController!.position.maxScrollExtent,
    );

    if (scrollController!.position.maxScrollExtent - scrollController!.offset <
        oldPosition) {
      
      if (!isSlider) scrolNotifier.value = false;
    } else {
      scrolNotifier.value = true;
    }

    oldPosition = scrollController!.position.maxScrollExtent - scrollController!.offset;
  }

  void setOffset(CacheBook? cache) async {
    if (cache != null) {
      scrollController!.animateTo(cache.headCurrentOffset,
          duration: const Duration(milliseconds: 350), curve: Curves.ease);

      if (scrollController!.hasClients) {
        progressNotifier.value = BookControlState(
          current: scrollController!.offset,
          total: scrollController!.position.maxScrollExtent,
        );
      }
    }
  }
}
