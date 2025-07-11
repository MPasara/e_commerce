// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'] as String?,
      description: json['description'] as String?,
      categoryId: (json['category_id'] as num).toInt(),
      productTypeId: (json['product_type_id'] as num).toInt(),
      category: CategoryResponse.fromJson(
        json['Category'] as Map<String, dynamic>,
      ),
      productType: ProductTypeResponse.fromJson(
        json['Product_type'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'price': instance.price,
      'image': instance.imageUrl,
      'description': instance.description,
      'category_id': instance.categoryId,
      'product_type_id': instance.productTypeId,
      'Category': instance.category,
      'Product_type': instance.productType,
    };
