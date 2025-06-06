import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_state.dart';
import 'package:shopzy/features/home/domain/entity/bottom_navigation_item.dart';

class MainPage extends ConsumerWidget {
  static const routeName = '/';

  final StatefulNavigationShell? navigationShell;
  final Widget? child;

  const MainPage({super.key, this.navigationShell, this.child})
    : assert(navigationShell != null || child != null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    return switch (authState) {
      AuthStateAuthenticated() => Scaffold(
        body: navigationShell ?? child,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.appColors.background,
          selectedItemColor: context.appColors.secondary,
          unselectedItemColor: Color(0xffDAA520),
          showUnselectedLabels: false,
          selectedLabelStyle: context.appTextStyles.label,
          type: BottomNavigationBarType.fixed,
          items:
              BottomNavigationItem.values
                  .map(
                    (bottomNavItem) => BottomNavigationBarItem(
                      icon: Icon(bottomNavItem.icon, size: 28),
                      label: bottomNavItem.title,
                    ),
                  )
                  .toList(),
          currentIndex:
              navigationShell != null
                  ? navigationShell!.currentIndex
                  : BottomNavigationItem.getIndexForLocation(
                    ref.read(baseRouterProvider).currentLocationUri.path,
                  ),
          onTap:
              (selectedIndex) => _onItemTapped(ref: ref, index: selectedIndex),
        ),
      ),
      _ => Scaffold(body: SizedBox()),
    };
  }

  void _onItemTapped({required WidgetRef ref, required int index}) {
    if (navigationShell != null) {
      navigationShell!.goBranch(
        index,
        initialLocation: index == navigationShell!.currentIndex,
      );
    } else {
      for (final item in BottomNavigationItem.values) {
        if (index == item.index) {
          ref.pushNamed(item.routeName);
          break;
        }
      }
    }
  }
}
