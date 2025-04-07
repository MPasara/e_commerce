import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:shopzy/common/domain/utils/string_extensions.dart';
import 'package:shopzy/example/presentation/pages/example_page.dart';
import 'package:shopzy/example/presentation/pages/example_simple_page.dart';
import 'package:shopzy/example/presentation/pages/form_example_page.dart';
import 'package:shopzy/example/presentation/pages/pagination_example_page.dart';
import 'package:shopzy/example/presentation/pages/pagination_stream_example_page.dart';

RouteBase getExampleRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) => GoRoute(
  path: ExamplePage.routeName.removeLeadingSlash,
  parentNavigatorKey: rootNavigatorKey,
  builder: (context, state) => ExamplePage(),
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: ExampleSimplePage.routeName.removeLeadingSlash,
      builder: (context, state) => ExampleSimplePage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: FormExamplePage.routeName.removeLeadingSlash,
      builder: (context, state) => FormExamplePage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: PaginationExamplePage.routeName.removeLeadingSlash,
      builder: (context, state) => PaginationExamplePage(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: PaginationStreamExamplePage.routeName.removeLeadingSlash,
      builder: (context, state) => PaginationStreamExamplePage(),
    ),
  ],
);
