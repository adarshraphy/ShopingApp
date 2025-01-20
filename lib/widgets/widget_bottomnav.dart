import 'package:flutter/material.dart';
import '../screens/cart_page.dart';
import '../screens/home_page.dart';
import '../screens/wishlist_page.dart';
int _currentIndex = 0;

final List<Widget> pages = [
  const HomePage(),
  const WishlistPage(),
  const CartPage(),
];
class WidgetBottomnav extends StatefulWidget {
  final int index;
  const WidgetBottomnav({super.key, required this.index});

  @override
  State<WidgetBottomnav> createState() => _WidgetBottomnavState();
}

class _WidgetBottomnavState extends State<WidgetBottomnav> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        iconSize: 30,
        items:[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: "",
              activeIcon: Icon(
                Icons.home,
                color: Colors.orangeAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              label: " ",
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.orangeAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
              label: "",
              activeIcon: Icon(
                Icons.shopping_bag,
                color: Colors.orangeAccent,
              )),
        ],
      ),
    );
  }
}
