import 'package:get/get.dart';

class CategoryController extends GetxController {
  final RxString selectedCategory = "Semua".obs;
  
  final List<String> categories = [
    "Semua",
    "Fiksi",
    "Non-Fiksi",
    "Pendidikan",
    "Teknologi",
    "Sastra",
    "Sejarah",
    "Bisnis"
  ];

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }
}
