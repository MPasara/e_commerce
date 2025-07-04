import 'package:flutter/material.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/image_assets.dart';
import 'package:shopzy/generated/l10n.dart';

class EmptyProductsList extends StatelessWidget {
  const EmptyProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(ImageAssets.sadPepe),
        Center(
          child: Text(
            S.of(context).emptyProductsListMessage,
            style: context.appTextStyles.title,
          ),
        ),
      ],
    );
  }
}
