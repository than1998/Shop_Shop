import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projectshopping/controllers/checkout_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckoutView extends StatelessWidget {
  CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.black,
                        size: 22,
                      )),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Checkout",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: QrImageView(
                      data:
                          "https://payment.spw.challenge/checkout?price=${checkoutController.price.value}",
                      version: QrVersions.auto,
                      size: 320,
                      gapless: false,
                    )),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: const Text(
                  'SCAN & PAY',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
                child: Text(
                  NumberFormat.simpleCurrency(locale: "th_TH")
                      .format(checkoutController.price.value),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ))
        ],
      )),
    );
  }
}
