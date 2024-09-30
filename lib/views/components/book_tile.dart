import 'package:flutter/material.dart';
import '../../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  BookTile({required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(book.imagePath),
      title: Text(book.title),
      subtitle: Text(book.author),
    );
  }
}