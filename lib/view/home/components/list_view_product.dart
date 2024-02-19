import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

Widget listViewProduct(context, List productList, onSavedProduct,onNextDetailProductPage) {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: productList.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          onNextDetailProductPage(productList[index],index);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            height: 130,
                            image:
                                NetworkImage(productList[index]["image_url"]),
                            placeholder:
                                AssetImage('assets/image/blackcat.jpg'))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 4, right: 4, top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productList[index]["name"] ?? '',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          Text(
                              NumberFormat.simpleCurrency(locale: "th_TH")
                                  .format(productList[index]["price"]),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () async {
                    onSavedProduct(
                        context,
                        index,
                        productList[index]["id"],
                        productList[index]["name"],
                        productList[index]["image_url"],
                        productList[index]["price"],
                        !productList[index]["isSaved"]);
                  },
                  icon: productList[index]["isSaved"]
                      ? const Icon(FontAwesomeIcons.solidHeart,
                          color: Colors.red)
                      : const Icon(FontAwesomeIcons.heart, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ),
  );
}
