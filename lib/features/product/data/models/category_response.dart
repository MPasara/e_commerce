// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  final int id;
  final String name;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  const CategoryResponse({
    required this.id,
    required this.name,
    this.isActive,
    this.createdAt,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  @override
  String toString() {
    return 'CategoryResponse(id: $id, name: $name, isActive: $isActive, createdAt: $createdAt)';
  }
}
