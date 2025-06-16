import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final double price;
  final String? imageUrl;
  final String? description;

  const Product({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
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
    );
  }

  @override
  List<Object?> get props {
    return [id, createdAt, name, price, imageUrl, description];
  }
}
