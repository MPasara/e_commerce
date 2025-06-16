import 'package:equatable/equatable.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final int offset;
  final bool hasMore;
  final bool isLoadingMore;

  const ProductState({
    required this.products,
    required this.offset,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  ProductState copyWith({
    List<Product>? products,
    int? offset,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ProductState(
      products: products ?? this.products,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [products, offset, hasMore, isLoadingMore];
}
