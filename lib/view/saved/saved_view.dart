import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectshopping/controllers/saved_controller.dart';
import 'components/list_view_saved_product.dart';

class SavedView extends StatefulWidget {
  @override
  State<SavedView> createState() =>
      _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  SavedController saveController = Get.put(SavedController());

  @override
  void initState() {
    super.initState();
    saveController.getSavedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SAVED",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: listViewSavedProduct(
                      context,
                      saveController.productList,
                      saveController.onSavedProduct,
                      saveController.onNextDetailProductPage)),
            ),
          ],
        ),
      ));
    }));
  }
}
