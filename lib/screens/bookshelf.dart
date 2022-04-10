import 'package:flutter/material.dart';
import 'package:handlib/screens/bookdetail.dart';
import 'package:provider/provider.dart';
import 'package:handlib/models/booklists.dart';
import 'package:handlib/models/shelf.dart';

class Bookshelf extends StatelessWidget {
  static const routeName = '/bookshelf';
  const Bookshelf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList(
            delegate:
            SliverChildBuilderDelegate((context, index) => _MyBooks(index)),
          ),
        ],
      ),
    );
  }
}

class _MyBooks extends StatelessWidget {
  final int index;
  const _MyBooks(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var book = context.select<BookLists, Book>(
          (bookshelf) => bookshelf.getByPosition(index),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LimitedBox(
        maxHeight: 500.0,
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(book.img), height: 300.0, fit: BoxFit.fill),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'Palatino',
              ),
            ),
            ElevatedButton(
              child: const Text('Details'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow.shade900,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Book_Details.routeName,
                  arguments: book,
                );
              },
            ),
            const SizedBox(width: 24),
            _AddButton(book: book),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Book book;
  const _AddButton({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInShelf = context.select<ShelfModel, bool>(
          (shelf) => shelf.books.contains(book),
    );

    return TextButton(
        onPressed: isInShelf
            ? null
            : () {
          var shelf = context.read<ShelfModel>();
          shelf.add(book);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null;
          }),
        ),
        child: isInShelf
            ? const Icon(Icons.bookmark_added, semanticLabel: 'ADDED')
            : const Icon(Icons.bookmark_add, semanticLabel: 'ADD')
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('BookLib'),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.book_outlined),
          onPressed: () => Navigator.pushNamed(context, '/shelf'),
        ),
      ],
    );
  }
}

class Book_Details extends StatelessWidget {
  static const routeName = '/book_details';
  const Book_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Book details'),
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(image: AssetImage(data.img)),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    data.title,
                    style: const TextStyle(fontSize: 20.0),
                  )),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Author: ' + data.author,
                    style: const TextStyle(fontSize: 16.0),
                  )),
              const SizedBox(width: 24),
              _AddButton(book: data),
              ElevatedButton(
              child: const Text('Read book'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow.shade900,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Book_content.routeName,
                  arguments: data,
                );
              },
            ),
            ],
          )),
    );
  }
}
