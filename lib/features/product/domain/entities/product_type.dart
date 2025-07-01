// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductType extends Equatable {
  final int id;
  final String name;
  final int categoryId;
  final bool? isActive;
  final DateTime? createdAt;

  const ProductType({
    required this.id,
    required this.name,
    required this.categoryId,
    this.isActive,
    this.createdAt,
  });

  ProductType copyWith({
    int? id,
    String? name,
    int? categoryId,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ProductType(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, categoryId, isActive, createdAt];
}
