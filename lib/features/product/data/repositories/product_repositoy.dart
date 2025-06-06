import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/features/product/data/mappers/product_entity_mapper.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';
import 'package:shopzy/generated/l10n.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    ref.read(databaseServiceProvider),
    ref.read(productEntityMapperProvider),
  ),
  name: 'Product Repository Provider',
);

abstract interface class ProductRepository {
  EitherFailureOr<List<Product>> getProducts();
}

class ProductRepositoryImpl
    with ErrorToFailureMixin
    implements ProductRepository {
  final DatabaseService _databaseService;
  final EntityMapper<Product, ProductResponse> _productMapper;

  const ProductRepositoryImpl(this._databaseService, this._productMapper);

  @override
  EitherFailureOr<List<Product>> getProducts() => execute(
    () async {
      final productReponseList = await _databaseService.fetchProducts();
      final products =
          productReponseList
              .map((productResponse) => _productMapper(productResponse))
              .toList();

      return Right(products);
    },
    errorResolver: GenericErrorResolver(
      failureTitle: S.current.productFetchError,
    ),
  );
}
