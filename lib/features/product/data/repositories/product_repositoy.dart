import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/features/product/data/mappers/product_entity_mapper.dart';
import 'package:shopzy/features/product/data/models/category_response.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/features/product/data/models/product_type_response.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/features/product/domain/entities/product_type.dart';
import 'package:shopzy/generated/l10n.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    ref.read(databaseServiceProvider),
    ref.read(productEntityMapperProvider),
    ref.read(categoryEntityMapperProvider),
    ref.read(productTypeEntityMapperProvider),
  ),
  name: 'Product Repository Provider',
);

abstract interface class ProductRepository {
  EitherFailureOr<List<Product>> getProducts({int offset = 0, int limit = 10});
  EitherFailureOr<List<ProductCategory>> getAllCategories();
  EitherFailureOr<List<ProductType>> getAllProductTypes();
}

class ProductRepositoryImpl
    with ErrorToFailureMixin
    implements ProductRepository {
  const ProductRepositoryImpl(
    this._databaseService,
    this._productMapper,
    this._categoryMapper,
    this._productTypeMapper,
  );

  final DatabaseService _databaseService;
  final EntityMapper<Product, ProductResponse> _productMapper;
  final EntityMapper<ProductCategory, CategoryResponse> _categoryMapper;
  final EntityMapper<ProductType, ProductTypeResponse> _productTypeMapper;

  @override
  EitherFailureOr<List<Product>> getProducts({
    int offset = 0,
    int limit = 10,
  }) => execute(
    () async {
      final result = await _databaseService.fetchProducts(
        offset: offset,
        limit: limit,
      );
      final products =
          result.items
              .map((productResponse) => _productMapper(productResponse))
              .toList();

      return Right(products);
    },
    errorResolver: GenericErrorResolver(
      failureTitle: S.current.productFetchError,
    ),
  );

  @override
  EitherFailureOr<List<ProductCategory>> getAllCategories() => execute(
    () async {
      final result = await _databaseService.fetchAllCategories();

      final categories =
          result
              .map((categoryResponse) => _categoryMapper(categoryResponse))
              .toList();

      return Right(categories);
    },
    errorResolver: GenericErrorResolver(
      failureTitle: S.current.productFetchError,
    ),
  );

  @override
  EitherFailureOr<List<ProductType>> getAllProductTypes() => execute(
    () async {
      final result = await _databaseService.fetchAllProductTypes();

      final productTypes =
          result.map((productTypeResponse) => _productTypeMapper(productTypeResponse)).toList();

      return Right(productTypes);
    },
    errorResolver: GenericErrorResolver(
      failureTitle: S.current.productFetchError,
    ),
  );
}
