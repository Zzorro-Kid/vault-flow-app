import 'package:flutter/material.dart';

class CategoryIconMapper {
  static IconData getIconData(String iconName) {
    return switch (iconName) {
      'restaurant' => Icons.restaurant,
      'directions_car' => Icons.directions_car,
      'shopping_cart' => Icons.shopping_cart,
      'movie' => Icons.movie,
      'local_hospital' => Icons.local_hospital,
      'account_balance_wallet' => Icons.account_balance_wallet,
      'work' => Icons.work,
      'trending_up' => Icons.trending_up,
      _ => Icons.category,
    };
  }
}
