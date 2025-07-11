import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/features/product/data/mappers/product_entity_mapper.dart';
import 'package:shopzy/features/product/domain/entities/category.dart';
import 'package:shopzy/generated/l10n.dart';

final selectedCategoryProvider = StateProvider<ProductCategory?>((ref) => null);

final categoriesProvider = FutureProvider<List<ProductCategory>>((ref) async {
  final db = ref.read(databaseServiceProvider);
  final mapper = ref.read(categoryEntityMapperProvider);
  final responses = await db.fetchAllCategories();
  return responses.map(mapper).toList();
});

class CategoryFilterSheet extends ConsumerWidget {
  const CategoryFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Container(
      decoration: BoxDecoration(
        color: context.appColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(flex: 2),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.appColors.secondary?.withAlpha(90),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 37),
                    child: TextButton(
                      onPressed:
                          selectedCategory == null
                              ? null
                              : () =>
                                  ref
                                      .read(selectedCategoryProvider.notifier)
                                      .state = null,
                      child: Text(
                        S.of(context).clearFilter,
                        style:
                            selectedCategory == null
                                ? context.appTextStyles.subtitle
                                : context.appTextStyles.regular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              S.of(context).filterByCategory,
              style: context.appTextStyles.title,
            ),
            const SizedBox(height: 16),
            categories.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (e, _) =>
                      Center(child: Text(S.of(context).failedToLoadCategories)),
              data:
                  (categories) => Column(
                    children: [
                      ...categories.map(
                        (category) => RadioListTile<ProductCategory>(
                          title: Text(
                            category.name,
                            style: context.appTextStyles.regular?.copyWith(
                              color: context.appColors.secondary,
                            ),
                          ),
                          value: category,
                          groupValue: selectedCategory,
                          activeColor: context.appColors.secondary,
                          onChanged: (value) {
                            ref.read(selectedCategoryProvider.notifier).state =
                                value;
                          },
                          tileColor: context.appColors.background,
                        ),
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
