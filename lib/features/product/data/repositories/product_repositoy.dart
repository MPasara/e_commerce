import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/features/product/data/mappers/product_entity_mapper.dart';
import 'package:shopzy/features/product/data/models/category_response.dart';
import 'package:shopzy/features/product/data/models/product_type_response.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/features/product/domain/entities/product_type.dart';
import 'package:shopzy/generated/l10n.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    ref.read(databaseServiceProvider),
    ref.read(categoryEntityMapperProvider),
    ref.read(productTypeEntityMapperProvider),
    ref,
  ),
  name: 'Product Repository Provider',
);

abstract interface class ProductRepository {
  EitherFailureOr<List<Product>> getAllProducts({
    int offset = 0,
    int limit = 10,
  });
}

class ProductRepositoryImpl
    with ErrorToFailureMixin
    implements ProductRepository {
  const ProductRepositoryImpl(
    this._databaseService,
    this._categoryMapper,
    this._productTypeMapper,
    this._ref,
  );

  final DatabaseService _databaseService;
  final EntityMapper<ProductCategory, CategoryResponse> _categoryMapper;
  final EntityMapper<ProductType, ProductTypeResponse> _productTypeMapper;
  final Ref _ref;

  @override
  EitherFailureOr<List<Product>> getAllProducts({
    int offset = 0,
    int limit = 10,
  }) => execute(
    () async {
      final result = await _databaseService.fetchProducts(
        offset: offset,
        limit: limit,
      );
      final categoriesResponse = await _databaseService.fetchAllCategories();
      final productTypesResponse =
          await _databaseService.fetchAllProductTypes();

      final categories = categoriesResponse.map(_categoryMapper).toList();
      final productTypes =
          productTypesResponse.map(_productTypeMapper).toList();

      final categoryMap = {for (final c in categories) c.id: c};
      final productTypeMap = {for (final pt in productTypes) pt.id: pt};

      final productMapper = _ref.read(
        productEntityMapperProvider(
          ProductEntityMapperLookups(
            categoryLookup: (id) => categoryMap[id],
            productTypeLookup: (id) => productTypeMap[id],
          ),
        ),
      );

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
