// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/features/product/data/models/category_response.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/features/product/data/models/product_type_response.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/features/product/domain/entities/product_type.dart';

final productEntityMapperProvider =
    Provider<EntityMapper<Product, ProductResponse>>((ref) {
      return (response) {
        final categoryMapper = ref.read(categoryEntityMapperProvider);
        final productTypeMapper = ref.read(productTypeEntityMapperProvider);

        return Product(
          id: response.id,
          createdAt: response.createdAt,
          name: response.name,
          price: response.price,
          imageUrl: response.imageUrl,
          description: response.description,
          category: categoryMapper(response.category),
          productType: productTypeMapper(response.productType),
        );
      };
    });

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
