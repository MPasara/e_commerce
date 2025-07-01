import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/features/product/data/models/category_response.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/features/product/data/models/product_type_response.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/features/product/domain/entities/product_type.dart';

final productEntityMapperProvider =
    Provider<EntityMapper<Product, ProductResponse>>(
      (ref) => (response) {
        return Product(
          id: response.id,
          createdAt: response.createdAt,
          name: response.name,
          price: response.price,
          description: response.description,
          imageUrl: response.imageUrl,
          category: getCategoryFromId(response.categoryId),
          productType: getProductTypeFromId(response.productTypeId),
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
        );
      },
    );

ProductCategory getCategoryFromId(int categoryId) {
  final category = ProductCategory(id: 1, name: 'Test categort');
  switch (categoryId) {
    case 5:
      return category;
    case 6:
      return category;
    case 7:
      return category;
    default:
      return category;
  }
}

ProductType getProductTypeFromId(int productTypeId) {
  final productType = ProductType(id: 1, name: 'Test type', categoryId: 1);
  switch (productTypeId) {
    case 19:
      return productType;
    case 20:
      return productType;
    case 21:
      return productType;
    case 22:
      return productType;
    case 23:
      return productType;
    case 24:
      return productType;
    case 25:
      return productType;
    case 26:
      return productType;
    case 27:
      return productType;
    default:
      return productType;
  }
}
