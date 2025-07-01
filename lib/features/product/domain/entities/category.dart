// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  final int id;
  final String name;
  final bool? isActive;
  final DateTime? createdAt;

  const ProductCategory({
    required this.id,
    required this.name,
    this.isActive,
    this.createdAt,
  });

  ProductCategory copyWith({
    int? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, isActive, createdAt];
}
