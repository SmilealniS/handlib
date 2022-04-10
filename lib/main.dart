import 'package:flutter/material.dart';
import 'package:handlib/screens/bookdetail.dart';
import 'package:provider/provider.dart';
import 'package:handlib/models/booklists.dart';
import 'package:handlib/models/shelf.dart';
import 'package:handlib/screens/bookshelf.dart';
import 'package:handlib/screens/login.dart';
import 'package:handlib/screens/shelf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => BookLists()),
        ChangeNotifierProxyProvider<BookLists, ShelfModel>(
          create: (context) => ShelfModel(),
          update: (context, booklists, shelf) {
            if (shelf == null) throw ArgumentError.notNull('shelf');
            shelf.booklists = booklists;
            return shelf;
          },
        ),
      ],
      child: MaterialApp(
        title: 'BookLib',
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.red.shade900,
            secondary: Colors.yellow.shade800,
          ),
        ),
        initialRoute: '/',
        routes: {
          Login.routeName: (context) => const Login(),
          Bookshelf.routeName: (context) => const Bookshelf(),
          Book_Details.routeName: (context) => const Book_Details(),
          Book_content.routeName: (context) => const Book_content(),
          Shelf.routeName:(context) => const Shelf(),
        },
      ),
    );
  }
}