import 'package:get/get.dart';
import '../models/book.dart';

class BookController extends GetxController {
  final List<Book> _books = [
    Book(
        title: 'Le Petit Prince',
        author: 'Antoine De Saint-Exupéry',
        imagePath: 'assets/images/le_petit_prince.jpg',
        isbn: '9786020398242'),
    Book(
        title: 'Il Principe',
        author: 'Niccolò Machiavelli',
        imagePath: 'assets/images/il_principe.jpg',
        isbn: '9786237586067'),
    Book(
        title: 'Paddington Bear',
        author: 'Michael Bond',
        imagePath: 'assets/images/tes.jpg',
        isbn: '9780062422750'),
    Book(
        title: 'The Little Engine',
        author: 'Watty Piper',
        imagePath: 'assets/images/wally.jpg',
        isbn: '9780448452579'),
    Book(
        title: 'Charlotte\'s Web',
        author: 'E.B. White',
        imagePath: 'assets/images/charlotte.jpg',
        isbn: '9780064400558'),
    Book(
        title: '1984',
        author: 'George Orwell',
        imagePath: 'assets/images/1984.jpg',
        isbn: '9780451524935'),
    Book(
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        imagePath: 'assets/images/gatsby.jpg',
        isbn: '9780743273565'),
  ].obs;

  // Getter untuk semua buku
  List<Book> get books => _books;

  // Fungsi pencarian buku
  List<Book> searchBooks(String query) {
    return _books.where((book) {
      final title = book.title.toLowerCase();
      final author = book.author.toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery) || author.contains(searchQuery);
    }).toList();
  }
}
