import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:handlib/models/shelf.dart';
import 'package:handlib/screens/bookshelf.dart';

class Shelf extends StatelessWidget {
  static const routeName = '/shelf';
  const Shelf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shelf'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _ShelfList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShelfList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var shelf = context.watch<ShelfModel>();

    return ListView.builder(
      itemCount: shelf.books.length,
      itemBuilder: (context, index) => ListTile(
        leading: ElevatedButton(
              child: const Text('Read'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow.shade900,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Book_Details.routeName,
                  arguments: shelf.books[index],
                );
              },
            ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            shelf.remove(shelf.books[index]);
          },
        ),
        title: Text(
          shelf.books[index].title,
        ),
      ),
    );
  }
}
