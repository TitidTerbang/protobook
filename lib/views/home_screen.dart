import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/book_controller.dart';
import 'components/book_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Buku',style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )),
      ),
      body: Obx(() => ListView.builder(
        itemCount: bookController.books.length,
        itemBuilder: (context, index) {
          return BookTile(book: bookController.books[index]);
        },
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.toNamed('/user'); // Gunakan Get.toNamed untuk navigasi
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: '',
          ),
        ],
      ),
    );
  }
}