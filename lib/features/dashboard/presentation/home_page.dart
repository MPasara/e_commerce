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
  final ScrollController _scrollController = ScrollController();

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
    if (_scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent * 0.7)) {
      ref.read(productNotifierProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productNotifierProvider);

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
          elevation: 0,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 16, 25, 4),
                child: ShopzyTextField.search(),
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
                        await ref
                            .read(productNotifierProvider.notifier)
                            .getProducts();
                      },
                      color: context.appColors.black,
                      backgroundColor: context.appColors.gold,
                      child: GridView.builder(
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
                            data.products.length + (data.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == data.products.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final product = data.products[index];
                          return ProductCard(product: product, onTap: () {});
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
