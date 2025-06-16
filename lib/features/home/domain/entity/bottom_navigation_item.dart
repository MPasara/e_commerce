import 'package:flutter/material.dart';
import 'package:shopzy/features/dashboard/presentation/home_page.dart';
import 'package:shopzy/features/directories/presentation/account_page.dart';
import 'package:shopzy/features/notifications/presentation/order_page.dart';
import 'package:shopzy/features/users/presentation/wishlist_page.dart';
import 'package:shopzy/generated/l10n.dart';

enum BottomNavigationItem {
  home(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    routeName: HomePage.routeName,
  ),
  wishlist(
    icon: Icons.favorite_outline_outlined,
    selectedIcon: Icons.favorite,
    routeName: WishlistPage.routeName,
  ),
  order(
    icon: Icons.shopping_bag_outlined,
    selectedIcon: Icons.shopping_bag,
    routeName: OrderPage.routeName,
  ),
  account(
    icon: Icons.person_2_outlined,
    selectedIcon: Icons.person_2,
    routeName: AccountPage.routeName,
  );

  final IconData icon;
  final IconData selectedIcon;
  final String routeName;

  const BottomNavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.routeName,
  });

  String get title => switch (this) {
    home => S.current.bottomNavHome,
    wishlist => S.current.bottomNavWishlist,
    order => S.current.bottomNavOrder,
    account => S.current.bottomNavAccount,
  };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.home,
          )
          .index;
}
