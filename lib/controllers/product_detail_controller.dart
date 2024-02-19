import 'package:get/get.dart';
import 'package:projectshopping/components/dialog/dialog.dart';
import 'package:projectshopping/main.dart';

class ProductDetailController extends GetxController {
  var argumentData = Get.arguments;
  var isSaved = false.obs;
  var product;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  Future<void> getProduct() async {
    product = argumentData[0]['Product'];
    isSaved.value = product.isSaved;
  }

  Future<void> onSavedProduct(context, isSavedPrduct) async {
    isSaved.value = isSavedPrduct;
    product.isSaved = isSavedPrduct;
    if (product.isSaved) {
      await objectbox.addSavedProduct(product.idProducts, product.name,
          product.imageUrl, product.price, product.isSaved);
    } else {
      final savedProduct =
          await objectbox.getProductByProductId(product.idProducts);
      await objectbox.removeSavedProductById(savedProduct.id);
    }
    customDialog(
        context, product.isSaved ? "Saved Success" : "Unsaved Success");
  }

  Future<void> addCart(context) async {
    final findProductCart =
        await objectbox.getProductCartByProductId(product.idProducts);
    if (findProductCart != null) {
      await objectbox.updateProductCart(findProductCart.id,true);
    } else {
      await objectbox.addProductCart(
          product.idProducts, product.name, product.imageUrl, product.price, 1);
    }
    customDialog(context, "Product added to cart successfully.");
  }
}
