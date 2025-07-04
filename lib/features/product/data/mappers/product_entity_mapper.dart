// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/features/product/data/models/category_response.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/features/product/data/models/product_type_response.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/features/product/domain/entities/product_type.dart';

typedef CategoryLookup = ProductCategory? Function(int id);
typedef ProductTypeLookup = ProductType? Function(int id);

class ProductEntityMapperLookups {
  final CategoryLookup categoryLookup;
  final ProductTypeLookup productTypeLookup;

  const ProductEntityMapperLookups({
    required this.categoryLookup,
    required this.productTypeLookup,
  });

  @override
  bool operator ==(covariant ProductEntityMapperLookups other) {
    if (identical(this, other)) return true;

    return other.categoryLookup == categoryLookup &&
        other.productTypeLookup == productTypeLookup;
  }

  @override
  int get hashCode => categoryLookup.hashCode ^ productTypeLookup.hashCode;
}

final productEntityMapperProvider = Provider.family<
  EntityMapper<Product, ProductResponse>,
  ProductEntityMapperLookups
>(
  (ref, lookups) => (response) {
    final category = lookups.categoryLookup(response.categoryId);
    final productType = lookups.productTypeLookup(response.productTypeId);

    if (category == null) {
      throw Exception('Category not found for id: ${response.categoryId}');
    }
    if (productType == null) {
      throw Exception(
        'ProductType not found for id: ${response.productTypeId}',
      );
    }

    return Product(
      id: response.id,
      createdAt: response.createdAt,
      name: response.name,
      price: response.price,
      description: response.description,
      imageUrl: response.imageUrl,
      category: category,
      productType: productType,
    );
  },
);

final categoryEntityMapperProvider =
    Provider<EntityMapper<ProductCategory, CategoryResponse>>(
      (ref) => (response) {
        return ProductCategory(
          id: response.id,
          name: response.name,
          createdAt: response.createdAt,
          isActive: response.isActive,
        );
      },
    );

final productTypeEntityMapperProvider =
    Provider<EntityMapper<ProductType, ProductTypeResponse>>(
      (ref) => (response) {
        return ProductType(
          id: response.id,
          name: response.name,
          categoryId: response.categoryId,
          isActive: response.isActive,
          createdAt: response.createdAt,
        );
      },
    );
