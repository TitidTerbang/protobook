import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// google books api key = AIzaSyAxUhyuum5GX9RlEN1tHLvYnWneAPSP24k

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title, style: GoogleFonts.montserrat()),
      ),
      body: FutureBuilder<Map<String, dynamic>>( // Ubah tipe data FutureBuilder
        future: fetchBookDetails(book.isbn), // Gunakan ISBN untuk mengambil data
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bookInfo = snapshot.data!; // Data buku dari API

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        book.imagePath, // Gambar masih dari aset lokal
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      bookInfo['title'] ?? 'Judul tidak tersedia',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Penulis: ${bookInfo['authors']?.join(', ') ?? 'Penulis tidak tersedia'}',
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Deskripsi:',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      bookInfo['description'] ?? 'Deskripsi tidak tersedia.',
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchBookDetails(String isbn) async {
    final apiKey = 'AIzaSyAxUhyuum5GX9RlEN1tHLvYnWneAPSP24k'; // Ganti dengan API key Anda
    final url = 'https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['totalItems'] > 0) {
        return json['items'][0]['volumeInfo'];
      } else {
        throw Exception('Buku dengan ISBN $isbn tidak ditemukan.');
      }
    } else {
      throw Exception('Gagal mengambil data dari Google Books API');
    }
  }
}