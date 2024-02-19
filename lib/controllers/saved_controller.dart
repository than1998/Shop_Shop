import 'package:get/get.dart';
import 'package:projectshopping/components/dialog/dialog.dart';
import 'package:projectshopping/main.dart';
import 'package:projectshopping/view/productDetail/product_detail_view.dart';

class SavedController extends GetxController {
  var productList = [].obs;

  Future<void> getSavedProducts() async {
    productList.clear();
    final savedProducts = await objectbox.getProducts();
    if (savedProducts.isNotEmpty) {
      productList.addAll(savedProducts);
    }
  }

  Future<void> onSavedProduct(context, index, int idProducts, String name,
      String imageUrl, double price, bool isSaved) async {
    productList[index].isSaved = isSaved;
    if (isSaved) {
      await objectbox.addSavedProduct(
          idProducts, name, imageUrl, price, isSaved);
    } else {
      final savedProduct = await objectbox.getProductByProductId(idProducts);
      await objectbox.removeSavedProductById(savedProduct.id);
    }
    getSavedProducts();
    customDialog(context, isSaved ? "Saved Success" : "Unsaved Success");
  }

  Future<void> onNextDetailProductPage(product) async {
    Get.to(
      () => ProductDetailView(),
      arguments: [
        {"Product": product}
      ],
    )?.then((value) async {
      getSavedProducts();
    });
  }
}
