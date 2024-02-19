import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectshopping/view/home/components/list_view_product.dart';
import 'package:projectshopping/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        return SafeArea(
            child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "SHOP SHOP",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: listViewProduct(
                        context,
                        homeController.productList,
                        homeController.onSavedProduct,
                        homeController.onNextDetailProductPage)),
              ),
            ],
          ),
        ));
      },
    ));
  }
}
