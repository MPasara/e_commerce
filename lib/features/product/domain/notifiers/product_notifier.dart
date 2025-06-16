import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:shopzy/features/product/data/repositories/product_repositoy.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';

final productNotifierProvider =
    NotifierProvider<ProductNotifier, BaseState<List<Product>>>(() {
      return ProductNotifier();
    }, name: 'Product Notifier Provider');

class ProductNotifier extends BaseNotifier<List<Product>> {
  late final ProductRepository _productRepository;
  static const int _limit = 10;
  int _currentOffset = 0;
  bool _hasMore = true;
  List<Product> _currentProducts = [];

  @override
  void prepareForBuild() {
    _productRepository = ref.watch(productRepositoryProvider);
  }

  Future<void> getProducts() async {
    _currentOffset = 0;
    _hasMore = true;
    _currentProducts = [];
    state = const BaseState.loading();

    final eitherFailureOrProducts = await _productRepository.getProducts(
      offset: _currentOffset,
      limit: _limit,
    );

    state = eitherFailureOrProducts.fold(
      (failure) => BaseState.error(failure),
      (products) {
        _currentProducts = products;
        _hasMore = products.length == _limit;
        return BaseState.data(_currentProducts);
      },
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore || state is BaseLoading) return;

    _currentOffset += _limit;

    final eitherFailureOrProducts = await _productRepository.getProducts(
      offset: _currentOffset,
      limit: _limit,
    );

    eitherFailureOrProducts.fold(
      (failure) {
        _currentOffset -= _limit;
        state = BaseState.error(failure);
      },
      (products) {
        if (products.isEmpty) {
          _hasMore = false;
          state = BaseState.data(_currentProducts);
        } else {
          _currentProducts = [..._currentProducts, ...products];
          _hasMore = products.length == _limit;
          state = BaseState.data(_currentProducts);
        }
      },
    );
  }
}
