import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const MyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black54,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.manage_search_outlined), label: "Browse"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Bag"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Account"),
      ],
    );
  }
}
