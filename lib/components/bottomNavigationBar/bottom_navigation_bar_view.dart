import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectshopping/view/cart/cart_view.dart';
import 'package:projectshopping/view/home/home_view.dart';
import 'package:projectshopping/view/saved/saved_view.dart';

class BottomNavigationBarView extends StatefulWidget {
  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  RxInt selectedPage = 0.obs;
  final List<Widget> pageOptions = [
    HomeView(),
    SavedView(),
    CartView(),
  ];
  List<TabItem> items = [
    const TabItem(
      icon: FontAwesomeIcons.house,
      title: 'Home',
    ),
    const TabItem(
      icon: FontAwesomeIcons.solidHeart,
      title: 'Saved',
    ),
    const TabItem(
      icon: FontAwesomeIcons.cartShopping,
      title: 'Cart',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pageOptions[selectedPage.value],
        bottomNavigationBar: BottomBarFloating(
            items: items,
            backgroundColor: Colors.white,
            color: Colors.grey,
            colorSelected: Colors.black,
            indexSelected: selectedPage.value,
            paddingVertical: 16,
            onTap: (int index) {
              selectedPage.value = index;
            }),
      );
    });
  }
}
