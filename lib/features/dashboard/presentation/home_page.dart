import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shopzy'),
        backgroundColor: context.appColors.background,
        elevation: 0.2,
        actions: [
          Icon(Icons.notifications_outlined),
          spacing20,
          Icon(Icons.shopping_cart_outlined),
          spacing20,
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
              Container(width: 30, height: 30, color: Colors.pink),
              spacing50,
            ],
          ),
        ),
      ),
    );
  }
}
