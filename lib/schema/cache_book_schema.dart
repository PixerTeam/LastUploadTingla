String cacheTable = 'cache_books';

class CacheBookFields {
  static const String bookId = 'book_id';
  static const String headIndex = 'head_index';
  static const String headCurrentOffset = 'head_current_offset';
  static const String headMaxOffset = 'head_max_offset';
  static const String audioCurrentOffset = 'audio_current_offset';
  static const String audioMaxOffset = 'audio_max_offset';
}

class CacheBook {
  String bookId;
  int headIndex;
  double headCurrentOffset;
  double headMaxOffset;
  int audioCurrentOffset;
  int audioMaxOffset;

  CacheBook({
    required this.bookId,
    required this.headIndex,
    required this.headCurrentOffset,
    required this.headMaxOffset,
    required this.audioCurrentOffset,
    required this.audioMaxOffset,
  });

  factory CacheBook.fromDatabase(Map<String, dynamic> map) => CacheBook(
        bookId: map[CacheBookFields.bookId],
        headIndex: map[CacheBookFields.headIndex],
        headCurrentOffset: map[CacheBookFields.headCurrentOffset],
        headMaxOffset: map[CacheBookFields.headMaxOffset],
        audioCurrentOffset: map[CacheBookFields.audioCurrentOffset],
        audioMaxOffset: map[CacheBookFields.audioMaxOffset],
      );

  Map<String, dynamic> toDatabase() => {
        CacheBookFields.bookId: bookId,
        CacheBookFields.headIndex: headIndex,
        CacheBookFields.headCurrentOffset: headCurrentOffset,
        CacheBookFields.headMaxOffset: headMaxOffset,
        CacheBookFields.audioCurrentOffset: audioCurrentOffset,
        CacheBookFields.audioMaxOffset: audioMaxOffset,
      };
}
