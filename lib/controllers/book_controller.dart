import 'package:get/get.dart';
import '../models/book.dart';

class BookController extends GetxController {
  final List<Book> _books = [
    Book(
        title: 'Le Petit Prince',
        author: 'Antoine De Saint-Exupéry',
        imagePath: 'assets/images/le_petit_prince.jpg',
        isbn: '9786020398242',
        category: 'Fiksi'),
    Book(
        title: 'Il Principe',
        author: 'Niccolò Machiavelli',
        imagePath: 'assets/images/il_principe.jpg',
        isbn: '9786237586067',
        category: 'Non-Fiksi'),
    Book(
        title: 'Paddington Bear',
        author: 'Michael Bond',
        imagePath: 'assets/images/tes.jpg',
        isbn: '9780062422750',
        category: 'Fiksi'),
    Book(
        title: 'The Little Engine',
        author: 'Watty Piper',
        imagePath: 'assets/images/wally.jpg',
        isbn: '9780448452579',
        category: 'Fiksi'),
    Book(
        title: 'Charlotte\'s Web',
        author: 'E.B. White',
        imagePath: 'assets/images/charlotte.jpg',
        isbn: '9780064400558',
        category: 'Fiksi'),
    Book(
        title: '1984',
        author: 'George Orwell',
        imagePath: 'assets/images/1984.jpg',
        isbn: '9780451524935',
        category: 'Fiksi'),
    Book(
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        imagePath: 'assets/images/gatsby.jpg',
        isbn: '9780743273565',
        category: 'Fiksi'),
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

  // Get filtered books by category
  List<Book> getBooksByCategory(String category) {
    if (category == "Semua") return _books;
    return _books.where((book) => book.category == category).toList();
  }
}
