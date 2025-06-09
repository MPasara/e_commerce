import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int _getCurrentIndex(WidgetRef ref) {
    if (navigationShell != null) {
      return navigationShell!.currentIndex;
    }
    return BottomNavigationItem.getIndexForLocation(
      ref.read(baseRouterProvider).currentLocationUri.path,
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return BottomNavigationItem.values.map((item) {
      return BottomNavigationBarItem(
        icon: Icon(item.icon, size: 28),
        activeIcon: Icon(item.selectedIcon, size: 28),
        label: item.title,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    return switch (authState) {
      AuthStateAuthenticated() => Scaffold(
        body: navigationShell ?? child,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.appColors.background,
          selectedItemColor: context.appColors.gold,
          unselectedItemColor: context.appColors.secondary,
          showUnselectedLabels: false,
          selectedLabelStyle: context.appTextStyles.label,
          type: BottomNavigationBarType.fixed,
          items: _buildNavigationItems(),
          currentIndex: _getCurrentIndex(ref),
          onTap: (selectedIndex) {
            HapticFeedback.mediumImpact;
            _onItemTapped(ref: ref, index: selectedIndex);
          },
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
