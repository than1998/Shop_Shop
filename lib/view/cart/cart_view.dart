import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectshopping/controllers/cart_controller.dart';
import 'package:projectshopping/view/cart/components/list_view_shopping_cart.dart';
import 'package:intl/intl.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.getProductsCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          return SafeArea(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CART",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: listViewShoppingCart(
                        context,
                        cartController.productCartList,
                        cartController.onDeleteProduct,
                        cartController.onPlusProduct,
                        cartController.onMinusProduct,
                      )),
                ),
              ],
            ),
          ));
        }),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: Obx(() {
                return Text(
                  "Total : ${NumberFormat.simpleCurrency(locale: "th_TH").format(cartController.totalPrice.value)}",
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                cartController.onNextCheckoutViewPage(context);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black)))),
              child: const Text(
                "Checkout",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ]),
        ));
  }
}
