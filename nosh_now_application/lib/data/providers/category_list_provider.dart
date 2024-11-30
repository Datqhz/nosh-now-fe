import 'package:flutter/material.dart';
import 'package:nosh_now_application/data/repositories/category_repository.dart';
import 'package:nosh_now_application/data/responses/get_categories_response.dart';

class CategoryListProvider with ChangeNotifier {
  List<GetCategoriesData> _categories = [];
  bool _isLoading = true;

  List<GetCategoriesData> get categories => _categories;
  bool get isLoading => _isLoading;

  void updateCategory(int id, GetCategoriesData newCategory) {
    final index = _categories.indexWhere((category) => category.categoryId == id);
    if (index != -1) {
      _categories[index].categoryName = newCategory.categoryName;
      _categories[index].categoryImage = newCategory.categoryImage;
      notifyListeners(); 
    }
  }
  void deleteCategory(int id) {
    final index = _categories.indexWhere((category) => category.categoryId == id);
    if (index != -1) {
      _categories.removeAt(index);
      notifyListeners(); 
    }
  }
  void addCategory(GetCategoriesData category) {
      _categories.add(category);
      notifyListeners(); 
    }


  Future<void> fetchCategories(BuildContext context) async {
    try {
      _categories = await CategoryRepository().getCategories(context);
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
}
