// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTypeResponse _$ProductTypeResponseFromJson(Map<String, dynamic> json) =>
    ProductTypeResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      isActive: json['is_active'] as bool?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      categoryId: (json['categoryId'] as num).toInt(),
    );

Map<String, dynamic> _$ProductTypeResponseToJson(
  ProductTypeResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'categoryId': instance.categoryId,
  'is_active': instance.isActive,
  'created_at': instance.createdAt?.toIso8601String(),
};
