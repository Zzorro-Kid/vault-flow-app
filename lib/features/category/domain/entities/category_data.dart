import 'package:equatable/equatable.dart';

class CategoryData extends Equatable {
  final String id;
  final String name;
  final String icon;
  final int color;
  final String type;

  const CategoryData({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, icon, color, type];
}
