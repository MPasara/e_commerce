// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shopzy/features/product/data/models/category_response.dart';
import 'package:shopzy/features/product/data/models/product_type_response.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final int id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String name;
  final double price;

  @JsonKey(name: 'image')
  final String? imageUrl;
  final String? description;

  @JsonKey(name: 'category_id')
  final int categoryId;

  @JsonKey(name: 'product_type_id')
  final int productTypeId;

  @JsonKey(name: 'Category')
  final CategoryResponse category;

  @JsonKey(name: 'Product_type')
  final ProductTypeResponse productType;

  const ProductResponse({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.categoryId,
    required this.productTypeId,
    required this.category,
    required this.productType,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  @override
  String toString() {
    return 'ProductResponse(id: $id, createdAt: $createdAt, name: $name, price: $price, imageUrl: $imageUrl, description: $description, category: $category, productType: $productType)';
  }
}
