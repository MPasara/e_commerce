import 'package:flutter/material.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';

class EmptyProductsList extends StatelessWidget {
  const EmptyProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/sad_pepe.png'),
        Center(
          child: Text('No items to show..', style: context.appTextStyles.title),
        ),
      ],
    );
  }
}
