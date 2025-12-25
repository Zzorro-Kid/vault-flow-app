import 'package:test_app/features/category/data/models/category_data_model.dart';

class DefaultCategories {
  DefaultCategories._();

  static const List<CategoryDataModel> expenseCategories = [
    CategoryDataModel(
      id: 'default_food',
      name: 'Food',
      icon: 'restaurant',
      color: 0xFFFF6B6B,
      type: 'expense',
    ),
    CategoryDataModel(
      id: 'default_transport',
      name: 'Transport',
      icon: 'directions_car',
      color: 0xFF4ECDC4,
      type: 'expense',
    ),
    CategoryDataModel(
      id: 'default_shopping',
      name: 'Shopping',
      icon: 'shopping_cart',
      color: 0xFFFFBE0B,
      type: 'expense',
    ),
    CategoryDataModel(
      id: 'default_entertainment',
      name: 'Entertainment',
      icon: 'movie',
      color: 0xFFE91E63,
      type: 'expense',
    ),
    CategoryDataModel(
      id: 'default_health',
      name: 'Health',
      icon: 'local_hospital',
      color: 0xFF9C27B0,
      type: 'expense',
    ),
  ];

  static const List<CategoryDataModel> incomeCategories = [
    CategoryDataModel(
      id: 'default_salary',
      name: 'Salary',
      icon: 'account_balance_wallet',
      color: 0xFF4CAF50,
      type: 'income',
    ),
    CategoryDataModel(
      id: 'default_freelance',
      name: 'Freelance',
      icon: 'work',
      color: 0xFF2196F3,
      type: 'income',
    ),
    CategoryDataModel(
      id: 'default_investment',
      name: 'Investment',
      icon: 'trending_up',
      color: 0xFF00BCD4,
      type: 'income',
    ),
  ];

  static List<CategoryDataModel> get all => [
        ...expenseCategories,
        ...incomeCategories,
      ];

  static List<CategoryDataModel> getByType(String type) {
    return type == 'expense' ? expenseCategories : incomeCategories;
  }
}