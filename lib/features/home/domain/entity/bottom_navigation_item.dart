import 'package:flutter/material.dart';
import 'package:shopzy/features/dashboard/presentation/home_page.dart';
import 'package:shopzy/features/directories/presentation/account_page.dart';
import 'package:shopzy/features/notifications/presentation/order_page.dart';
import 'package:shopzy/features/users/presentation/wishlist_page.dart';
import 'package:shopzy/generated/l10n.dart';

enum BottomNavigationItem {
  home(icon: Icons.home_outlined, routeName: HomePage.routeName),
  wishlist(
    icon: Icons.favorite_outline_outlined,
    routeName: WishlistPage.routeName,
  ),
  order(icon: Icons.shopping_bag_outlined, routeName: OrderPage.routeName),
  account(icon: Icons.person_2_outlined, routeName: AccountPage.routeName);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

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
