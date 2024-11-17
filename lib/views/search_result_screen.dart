import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto_book/controllers/book_controller.dart';
import 'package:proto_book/views/components/book_tile.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;

  SearchResultScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    final bookController = Get.find<BookController>();

    // Filter buku berdasarkan query
    final searchResults = bookController.books.where((book) {
      final title = book.title.toLowerCase();
      final author = book.author.toLowerCase();
      return title.contains(query.toLowerCase()) || author.contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Pencarian',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: searchResults.isEmpty
          ? Center(
        child: Text(
          'Tidak ada hasil untuk "$query"',
          style: GoogleFonts.montserrat(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final book = searchResults[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed('/bookDetail', arguments: book);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: BookTile(book: book),
            ),
          );
        },
      ),
    );
  }
}
