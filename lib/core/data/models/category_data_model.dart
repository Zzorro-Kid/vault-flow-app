import 'package:test_app/core/domain/entities/category_data.dart';

class CategoryDataModel extends CategoryData {
  const CategoryDataModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.color,
    required super.type,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as int,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'color': color, 'type': type};
  }

  CategoryDataModel copyWith({
    String? id,
    String? name,
    String? icon,
    int? color,
    String? type,
  }) {
    return CategoryDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }
}
