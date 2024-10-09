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
  ].obs;

  List<Book> get books => _books;
}
