import 'package:get/get.dart';
import '../models/book.dart';

class BookController extends GetxController {
  final List<Book> _books = [
    Book(
        title: 'Le Petit Prince',
        author: 'Antoine De Saint-Exupéry',
        imageUrl: 'https://m.media-amazon.com/images/I/61NGp-UxolL._AC_UF1000,1000_QL80_.jpg'),
    Book(
        title: 'Il Principe',
        author: 'Niccolò Machiavelli',
        imageUrl: 'https://m.media-amazon.com/images/I/71BoTYIhOWL._AC_UF1000,1000_QL80_.jpg'),
    // Tambahkan buku lainnya di sini
  ].obs;

  List<Book> get books => _books;
}