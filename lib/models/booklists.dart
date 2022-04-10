import 'package:flutter/material.dart';

class BookLists {
  static Book harry1 = Book(1, "Harry Potter and the Philosopher's Stone",
      "assets/cover/harry1.jpeg", "J.K. Rowling", "assets/content/harry1.pdf");

  static Book harry2 = Book(2, "Harry Potter and the Chamber of Secrets",
      "assets/cover/harry2.jpeg", "J.K. Rowling", "assets/content/harry2.pdf");

  static Book harry3 = Book(3, "Harry Potter and the Prisoner of Azkaban",
      "assets/cover/harry3.jpeg", "J.K. Rowling", "assets/content/harry3.pdf");

  static Book harry4 = Book(4, "Harry Potter and the Goblet of Fire",
      "assets/cover/harry4.jpeg", "J.K. Rowling", "assets/content/harry4.pdf");

  static Book harry5 = Book(5, "Harry Potter and the Order of the Phoenix",
      "assets/cover/harry5.jpeg", "J.K. Rowling", "assets/content/harry5.pdf");

  static Book harry6 = Book(6, "Harry Potter and the Half-Blood Prince",
      "assets/cover/harry6.jpeg", "J.K. Rowling", "assets/content/harry6.pdf");

  static Book harry7 = Book(7, "Harry Potter and the Deadly Hallows",
      "assets/cover/harry7.jpeg", "J.K. Rowling", "assets/content/harry7.pdf");

  static Book letlifespeak = Book(
      8,
      "Let Your Life Speak: Listening for the Voice of Vocation",
      "assets/cover/letlifespeak.jpg",
      "Parker J. Palmer", "assets/content/letlifespeak.pdf");

  static List<Book> bookList = [
    harry1,
    harry2,
    harry3,
    harry4,
    harry5,
    harry6,
    harry7,
    letlifespeak
  ];

  Book getById(int id) => Book(
      id,
      bookList[id % bookList.length].title,
      bookList[id % bookList.length].img,
      bookList[id % bookList.length].author,
      bookList[id % bookList.length].pdf);

  Book getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Book {
  final int id;
  final String title;
  final String img;
  final String author;
  final String pdf;

  Book(
    this.id,
    this.title,
    this.img,
    this.author,
    this.pdf,
  );
}
