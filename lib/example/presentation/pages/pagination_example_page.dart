import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/example/domain/notifiers/example_pagination/example_paginated_notifier.dart';

class PaginationExamplePage extends ConsumerWidget {
  static const routeName = '/pagination-example-page';

  const PaginationExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagination')),
      body: PaginatedListView(
        itemBuilder: (context, word, index) => _PaginationExampleTile(word),
        autoDisposeNotifierProvider: paginatedNotifierProvider,
        emptyListBuilder:
            (refresh) => Center(
              child: Text('list empty', style: context.appTextStyles.regular),
            ),
        onError: (failure, listIsEmpty, onRefresh) {
          logDebug('failure occurred: $failure');
          if (listIsEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $failure', style: context.appTextStyles.regular),
                TextButton(
                  onPressed: onRefresh,
                  child: Text('Refresh', style: context.appTextStyles.bold),
                ),
              ],
            );
          }
          return null;
        },
      ),
    );
  }
}

class _PaginationExampleTile extends StatelessWidget {
  final String word;
  const _PaginationExampleTile(this.word);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text(word, style: context.appTextStyles.boldLarge),
    );
  }
}
