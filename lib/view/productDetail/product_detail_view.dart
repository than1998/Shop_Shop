import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projectshopping/controllers/product_detail_controller.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailController productDetailController =
      Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Get.back(result: productDetailController.isSaved.value);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.black,
                    size: 22,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: FadeInImage(
                    fit: BoxFit.fill,
                    height: 300,
                    image:
                        NetworkImage(productDetailController.product.imageUrl),
                    placeholder:
                        const AssetImage('assets/image/blackcat.jpg'))),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      productDetailController.product.name,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Obx(() {
                      return IconButton(
                        onPressed: () {
                          productDetailController.onSavedProduct(context,!productDetailController.isSaved.value);
                        },
                        icon: productDetailController.isSaved.value
                            ? const Icon(FontAwesomeIcons.solidHeart,
                                color: Colors.red)
                            : const Icon(FontAwesomeIcons.heart,
                                color: Colors.black),
                      );
                    }),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              NumberFormat.simpleCurrency(locale: "th_TH")
                  .format(productDetailController.product.price),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            productDetailController.addCart(context);
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.black)))),
          child: const Text(
            "Add to Cart",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
