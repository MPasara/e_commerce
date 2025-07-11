// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'product_type_response.g.dart';

@JsonSerializable()
class ProductTypeResponse {
  final int id;
  final String name;
  @JsonKey(name: 'category_id')
  final int categoryId;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  const ProductTypeResponse({
    required this.id,
    required this.name,
    this.isActive,
    this.createdAt,
    required this.categoryId,
  });

  factory ProductTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeResponseFromJson(json);

  @override
  String toString() {
    return 'ProductTypeResponse(id: $id, name: $name, categoryId: $categoryId, isActive: $isActive, createdAt: $createdAt)';
  }
}
