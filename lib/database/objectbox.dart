import 'package:projectshopping/models/products_cart_models.dart';
import 'package:projectshopping/models/products_models.dart';
import 'package:projectshopping/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Products> productsBox;
  late final Box<ProductsCart> productsCartBox;

  ObjectBox._create(this._store) {
    productsBox = Box<Products>(_store);
    productsCartBox = Box<ProductsCart>(_store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  //=============================================================Saved Product Start=============================================================
  Future<void> addSavedProduct(int idProducts, String name, String imageUrl,
      double price, bool isSaved) async {
    productsBox
        .put(Products(idProducts, name, imageUrl, price, isSaved: isSaved));
  }

  Future<List<Products>> getProducts() async {
    return productsBox.getAll();
  }

  Future<Products> getProductByProductId(int productId) async {
    final query = (productsBox.query(Products_.idProducts.equals(productId))
          ..order(Products_.idProducts))
        .build();
    final results = query.find();
    query.close();
    return results.last;
  }

  Future<bool> removeSavedProductById(int id) async {
    return productsBox.remove(id);
  }

  //=============================================================Saved Product End=============================================================

  //=============================================================Product Cart Start=============================================================

  Future<void> addProductCart(int idProducts, String name, String imageUrl,
      double price, int amount) async {
    productsCartBox
        .put(ProductsCart(idProducts, name, imageUrl, price, amount));
  }

  Future<void> updateProductCart(int id,bool isPlus) async {
    final update = productsCartBox.get(id)!;
    update.amount = isPlus ? (update.amount) + 1 : (update.amount) - 1;
    productsCartBox.put(update);
  }

  Future<List<ProductsCart>> getProductsCart() async {
    return productsCartBox.getAll();
  }

  Future<ProductsCart?> getProductCartByProductId(int productId) async {
    try {
      final query =
          (productsCartBox.query(ProductsCart_.idProducts.equals(productId))
                ..order(ProductsCart_.idProducts))
              .build();
      final results = query.find();
      query.close();
      return results.last;
    } catch (error) {
      return null;
    }
  }

  Future<bool> removeSavedProductCartById(int id) async {
    return productsCartBox.remove(id);
  }
//=============================================================Product Cart End=============================================================
}
