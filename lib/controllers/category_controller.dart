import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'book_controller.dart';

class CategoryController extends GetxController {
  final RxString selectedCategory = "Semua".obs;
  final BookController bookController = Get.find<BookController>();

  // Add color map for categories
  final Map<String, Color> categoryColors = {
    "Semua": Colors.blue,
    "Novel": Colors.purple,
    "Komik": Colors.orange,
    "Pendidikan": Colors.green,
    "Fiksi": Colors.red,
    "Non-Fiksi": Colors.teal,
  };

  List<String> get categories {
    // Get unique categories from books
    Set<String> uniqueCategories = bookController.books
        .map((book) => book.category)
        .toSet();

    // Add "Semua" as first option and sort the rest
    List<String> allCategories = ["Semua", ...uniqueCategories];
    return allCategories;
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }
}
