import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:shopzy/features/product/data/repositories/product_repositoy.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';

final productNotifierProvider =
    NotifierProvider<ProductNotifier, BaseState<List<Product>>>(() {
      return ProductNotifier();
    }, name: 'Product Notifier Provider');

class ProductNotifier extends Notifier<BaseState<List<Product>>> {
  late final ProductRepository _productRepository;

  @override
  BaseState<List<Product>> build() {
    _productRepository = ref.watch(productRepositoryProvider);
    return const BaseState.initial();
  }

  Future<void> getProducts() async {
    state = const BaseState.loading();

    final eitherFailureOrProducts = await _productRepository.getProducts();
    state = eitherFailureOrProducts.fold(
      (failure) => BaseState.error(failure),
      (products) => BaseState.data(products),
    );
  }
}
