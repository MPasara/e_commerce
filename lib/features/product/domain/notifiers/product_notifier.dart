import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:shopzy/features/product/data/repositories/product_repositoy.dart';
import 'package:shopzy/features/product/domain/notifiers/product_state.dart';

final productNotifierProvider =
    NotifierProvider<ProductNotifier, BaseState<ProductState>>(() {
      return ProductNotifier();
    }, name: 'Product Notifier Provider');

class ProductNotifier extends BaseNotifier<ProductState> {
  late final ProductRepository _productRepository;
  static const int _limit = 10;

  @override
  void prepareForBuild() {
    _productRepository = ref.watch(productRepositoryProvider);
  }

  Future<void> getProducts() async {
    state = const BaseState.loading();

    final eitherFailureOrProducts = await _productRepository.getProducts(
      offset: 0,
      limit: _limit,
    );

    state = eitherFailureOrProducts.fold(
      (failure) => BaseState.error(failure),
      (products) => BaseState.data(
        ProductState(
          products: products,
          offset: _limit,
          hasMore: products.length == _limit,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! BaseData<ProductState> ||
        !currentState.data.hasMore ||
        currentState.data.isLoadingMore) {
      return;
    }

    state = BaseState.data(currentState.data.copyWith(isLoadingMore: true));

    final eitherFailureOrProducts = await _productRepository.getProducts(
      offset: currentState.data.offset,
      limit: _limit,
    );

    state = eitherFailureOrProducts.fold(
      (failure) {
        setGlobalFailure(failure);
        return BaseState.data(currentState.data.copyWith(isLoadingMore: false));
      },
      (products) {
        if (products.isEmpty) {
          return BaseState.data(
            currentState.data.copyWith(hasMore: false, isLoadingMore: false),
          );
        } else {
          final newProducts = [...currentState.data.products, ...products];
          return BaseState.data(
            currentState.data.copyWith(
              products: newProducts,
              offset: currentState.data.offset + _limit,
              hasMore: products.length == _limit,
              isLoadingMore: false,
            ),
          );
        }
      },
    );
  }
}
