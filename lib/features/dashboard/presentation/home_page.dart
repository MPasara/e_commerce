import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/features/dashboard/presentation/widgets/category_filter_sheet.dart';
import 'package:shopzy/features/dashboard/presentation/widgets/empty_products_list.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:shopzy/features/product/domain/notifiers/product_notifier.dart';
import 'package:shopzy/features/product/presentation/widgets/product_card.dart';
import 'package:shopzy/generated/l10n.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showSearchField = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(productNotifierProvider.notifier).getProducts(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.position.pixels;

    if (offset <= 0 && !_showSearchField) {
      setState(() => _showSearchField = true);
    } else if (offset > _lastOffset + 3 && _showSearchField) {
      setState(() => _showSearchField = false);
    } else if (offset < _lastOffset - 3 && !_showSearchField) {
      setState(() => _showSearchField = true);
    }
    _lastOffset = offset;

    if (offset >= (_scrollController.position.maxScrollExtent * 0.7)) {
      ref.read(productNotifierProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productNotifierProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).appName,
            style: context.appTextStyles.title,
          ),
          backgroundColor: context.appColors.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.tune, color: context.appColors.secondary),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => CategoryFilterSheet(),
              );
            },
          ),
          actions: [
            Icon(
              Icons.notifications_outlined,
              color: context.appColors.secondary,
            ),
            spacing20,
            Icon(
              Icons.shopping_cart_outlined,
              color: context.appColors.secondary,
            ),
            spacing20,
          ],
        ),
        body: switch (productsState) {
          BaseInitial() => const SizedBox.shrink(),
          BaseLoading() => Center(
            child: CircularProgressIndicator(
              color: context.appColors.secondary,
            ),
          ),
          BaseError(:final failure) => Center(
            child: Text(
              'Error: ${failure.error}',
              style: TextStyle(color: context.appColors.errorRed),
            ),
          ),
          BaseData(:final data) => Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showSearchField ? 1.0 : 0.0,
                  curve: Curves.linear,
                  child:
                      _showSearchField
                          ? Padding(
                            padding: const EdgeInsets.fromLTRB(25, 16, 25, 4),
                            child: ShopzyTextField.search(),
                          )
                          : const SizedBox.shrink(),
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    FocusScope.of(context).unfocus();
                    return false;
                  },
                  child: RawScrollbar(
                    padding: const EdgeInsets.only(right: 2),
                    interactive: true,
                    thumbColor: context.appColors.scrollbarColor,
                    controller: _scrollController,
                    radius: const Radius.circular(8),
                    thickness: 4,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() => _showSearchField = true);
                        await ref
                            .read(productNotifierProvider.notifier)
                            .getProducts();
                      },
                      color: context.appColors.black,
                      backgroundColor: context.appColors.gold,
                      child: Builder(
                        builder: (context) {
                          final filteredProducts =
                              selectedCategory == null
                                  ? data.products
                                  : data.products
                                      .where(
                                        (product) =>
                                            product.category.id ==
                                            selectedCategory.id,
                                      )
                                      .toList();
                          return filteredProducts.isEmpty
                              ? EmptyProductsList()
                              : GridView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(16),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20,
                                    ),
                                itemCount:
                                    filteredProducts.length +
                                    (data.isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == filteredProducts.length) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final product = filteredProducts[index];
                                  return ProductCard(
                                    product: product,
                                    onTap: () {},
                                  );
                                },
                              );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        },
      ),
    );
  }
}
