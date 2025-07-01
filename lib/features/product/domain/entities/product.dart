import 'package:equatable/equatable.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product_type.dart';

class Product extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final double price;
  final String? imageUrl;
  final String? description;
  final ProductCategory category;
  final ProductType productType;

  const Product({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
    required this.category,
    required this.productType,
  });

  Product copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category,
      productType: productType,
    );
  }

  @override
  List<Object?> get props {
    return [id, createdAt, name, price, imageUrl, description];
  }
}
