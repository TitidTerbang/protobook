class Book {
  final String title;
  final String author;
  final String imagePath;
  final String isbn;
  final String category;
  
  Book({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.isbn,
    required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      imagePath: json['imagePath'],
      isbn: json['isbn'],
      category: json['category'] ?? 'Semua',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'imagePath': imagePath,
      'isbn': isbn,
      'category': category,
    };
  }
}