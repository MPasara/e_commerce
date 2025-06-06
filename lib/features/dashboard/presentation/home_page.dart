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
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(productNotifierProvider.notifier).getProducts();
    });
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
        body: SingleChildScrollView(
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
                  BaseLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  BaseError(:final failure) => Center(
                    child: Text(
                      'Error: ${failure.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  BaseData(:final data) => SizedBox(
                    height: MediaQuery.sizeOf(context).height - 200,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 20,
                        bottom: 85,
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
                        return ProductCard(product: product, onTap: () {});
                      },
                    ),
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
