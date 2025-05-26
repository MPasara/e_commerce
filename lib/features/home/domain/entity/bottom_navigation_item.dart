import 'package:flutter/material.dart';
import 'package:shopzy/features/dashboard/presentation/home_page.dart';
import 'package:shopzy/features/directories/presentation/directories_page.dart';
import 'package:shopzy/features/notifications/presentation/notifications_page.dart';
import 'package:shopzy/features/users/presentation/users_page.dart';

enum BottomNavigationItem {
  home(icon: Icons.home, routeName: HomePage.routeName),
  wishlist(
    icon: Icons.favorite_outline_outlined,
    routeName: UsersPage.routeName,
  ),
  order(
    icon: Icons.shopping_bag_outlined,
    routeName: NotificationsPage.routeName,
  ),
  account(icon: Icons.person_2_outlined, routeName: DirectoriesPage.routeName);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

  String get title => switch (this) {
    home => 'Home',
    wishlist => 'Wishlist',
    order => 'Order',
    account => 'Account',
  };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.home,
          )
          .index;
}
