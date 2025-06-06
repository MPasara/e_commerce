import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/features/product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: context.appColors.appTextFieldFill,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child:
                    product.imageUrl != null
                        ? CachedNetworkImage(
                          imageUrl: product.imageUrl!,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.error_outline,
                                  color: Colors.grey,
                                ),
                              ),
                        )
                        : Container(
                          height: 120,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                          ),
                        ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.toUpperCase(),
                      style: context.appTextStyles.regular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '€${product.price.toStringAsFixed(2)}',
                      style: context.appTextStyles.regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
