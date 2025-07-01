// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

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

  const ProductResponse({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.categoryId,
    required this.productTypeId,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  

  @override
  String toString() {
    return 'ProductResponse(id: $id, createdAt: $createdAt, name: $name, price: $price, imageUrl: $imageUrl, description: $description, categoryId: $categoryId, productTypeId: $productTypeId)';
  }
}
