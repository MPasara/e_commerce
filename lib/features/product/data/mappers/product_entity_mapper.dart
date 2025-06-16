import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';

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
        );
      },
    );
