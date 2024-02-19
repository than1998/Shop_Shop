import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projectshopping/components/dialog/dialog.dart';
import 'package:projectshopping/main.dart';
import 'package:projectshopping/models/products_models.dart';
import 'package:projectshopping/view/productDetail/product_detail_view.dart';

class HomeController extends GetxController {
  var productList = [].obs;

  Future<void> getProducts() async {
    productList.clear();
    final String response =
    await rootBundle.loadString('assets/jsonFile/products.json');
    final data = await json.decode(response);
    List list = data["product_items"];
    final newList = list.map((obj) => {...obj, "isSaved": false}).toList();
    productList.addAll(newList);
    final savedProducts = await objectbox.getProducts();
    if (savedProducts.isNotEmpty) {
      productList.forEach((element) {
        final findProduct =
        savedProducts.where((item) => element["id"] == item.idProducts);
        if (findProduct.isNotEmpty) {
          element["isSaved"] = findProduct.last.isSaved;
        }
      });
    }
  }

  Future<void> onSavedProduct(context, index, int idProducts, String name,
      String imageUrl,
      double price, bool isSaved) async {
    productList[index]["isSaved"] = isSaved;
    if (isSaved) {
      await objectbox.addSavedProduct(
          idProducts, name, imageUrl, price, isSaved);
    } else {
      final savedProduct = await objectbox.getProductByProductId(idProducts);
      await objectbox.removeSavedProductById(savedProduct.id);
    }
    productList.refresh();
    customDialog(context, isSaved ? "Saved Success" : "Unsaved Success");
  }

  Future<void> onNextDetailProductPage(product,index) async {
    var newProduct = Products(
        product["id"], product["name"], product["image_url"], product["price"],
        isSaved: product["isSaved"]);
    Get.to(
          () => ProductDetailView(),
      arguments: [
        {"Product": newProduct}
      ],
    )?.then((value) async {
      if (value != product["isSaved"]) {
        productList[index]["isSaved"] = value;
      }
      productList.refresh();
    });
  }
}
