import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectshopping/components/dialog/dialog.dart';
import 'package:projectshopping/main.dart';
import 'package:projectshopping/view/checkout/checkout_view.dart';

class CartController extends GetxController {
  var productCartList = [].obs;
  RxDouble totalPrice = 0.0.obs;

  Future<void> getProductsCart() async {
    productCartList.clear();
    final productsCart = await objectbox.getProductsCart();
    if (productsCart.isNotEmpty) {
      productCartList.addAll(productsCart);
      getTotalAmount();
    } else {
      totalPrice.value = 0.0;
    }
  }

  void getTotalAmount() {
    totalPrice.value = 0.0;
    productCartList.forEach((element) {
      totalPrice.value = totalPrice.value + (element.price * element.amount);
    });
  }

  Future<void> onDeleteProduct(context, id) async {
    await objectbox.removeSavedProductCartById(id);
    getProductsCart();
    customDialog(context, "Product successfully deleted.");
  }

  Future<void> onPlusProduct(context, idProducts) async {
    final findProductCart =
        await objectbox.getProductCartByProductId(idProducts);
    await objectbox.updateProductCart(findProductCart!.id, true);
    getProductsCart();
  }

  Future<void> onMinusProduct(context, idProducts) async {
    final findProductCart =
        await objectbox.getProductCartByProductId(idProducts);
    await objectbox.updateProductCart(findProductCart!.id, false);
    getProductsCart();
  }

  Future<void> onNextCheckoutViewPage(context) async {
    if (totalPrice.value > 0) {
      Get.to(
        () => CheckoutView(),
        arguments: [
          {"Price": totalPrice.value}
        ],
      );
    } else {
      const snackBar = SnackBar(
        content: Text("There are no products in the cart."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
