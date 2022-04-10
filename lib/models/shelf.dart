import 'package:flutter/foundation.dart';
import 'booklists.dart';

class ShelfModel extends ChangeNotifier {
  late BookLists _bookLists;
  final List<int> _bookIds = [];

  BookLists get booklists => _bookLists;

  set booklists(BookLists newbooklists) {
    _bookLists = newbooklists;
    notifyListeners();
  }

  List<Book> get books => _bookIds.map((id) => _bookLists.getById(id)).toList();

  void add(Book book) {
    _bookIds.add(book.id);
    notifyListeners();
  }

  void remove(Book book) {
    _bookIds.remove(book.id);
    notifyListeners();
  }
}