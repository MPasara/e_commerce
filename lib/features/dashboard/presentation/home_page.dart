import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
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
  bool _hasMore = false;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      ref.read(productNotifierProvider.notifier).getProducts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);
    try {
      await ref.read(productNotifierProvider.notifier).loadMore();
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productNotifierProvider);
    _hasMore = ref.read(productNotifierProvider.notifier).hasMore;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).appName,
            style: context.appTextStyles.title,
          ),
          backgroundColor: context.appColors.background,
          elevation: 0.2,
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
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.read(productNotifierProvider.notifier).getProducts();
          },
          color: context.appColors.secondary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spacing16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ShopzyTextField.search(),
                  ),
                  spacing4,
                  // Display products based on state
                  switch (productsState) {
                    BaseInitial() => const SizedBox.shrink(),
                    BaseLoading() => Center(
                      child: CircularProgressIndicator(
                        color: context.appColors.secondary,
                      ),
                    ),
                    BaseError(:final failure) => Center(
                      child: Text(
                        'Error: ${failure.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    BaseData(:final data) => SizedBox(
                      height: MediaQuery.sizeOf(context).height - 200,
                      child: RawScrollbar(
                        padding: EdgeInsets.only(right: 2),
                        interactive: true,
                        thumbColor: context.appColors.scrollbarColor,
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 20,
                                  bottom: 20,
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20,
                                    ),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final product = data[index];
                                  return ProductCard(
                                    product: product,
                                    onTap: () {},
                                  );
                                },
                              ),
                            ),
                            if (_hasMore)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: CircularProgressIndicator(
                                  color: context.appColors.secondary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
