import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/features/product/data/mappers/product_entity_mapper.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/generated/l10n.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(ref.read(databaseServiceProvider), ref),
  name: 'Product Repository Provider',
);

abstract interface class ProductRepository {
  EitherFailureOr<List<Product>> getAllProducts({
    int offset = 0,
    int limit = 10,
    ProductCategory? selectedCategory,
  });
}

class ProductRepositoryImpl
    with ErrorToFailureMixin
    implements ProductRepository {
  const ProductRepositoryImpl(this._databaseService, this._ref);

  final DatabaseService _databaseService;
  final Ref _ref;

  @override
  EitherFailureOr<List<Product>> getAllProducts({
    int offset = 0,
    int limit = 10,
    ProductCategory? selectedCategory,
  }) => execute(
    () async {
      final result = await _databaseService.fetchProducts(
        offset: offset,
        limit: limit,
        selectedCategory: selectedCategory,
      );

      final productMapper = _ref.read(productEntityMapperProvider);

      final products =
          result.items
              .map((productResponse) => productMapper(productResponse))
              .toList();

      return Right(products);
    },
    errorResolver: GenericErrorResolver(
      failureTitle: S.current.productFetchError,
    ),
  );
}
