import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var argumentData = Get.arguments;
  var price = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCheckoutData();
  }

  Future<void> getCheckoutData() async {
    price.value = argumentData[0]['Price'];
  }
}