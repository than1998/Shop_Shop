import 'package:objectbox/objectbox.dart';

@Entity()
class ProductsCart {
  @Id()
  int id;

  int idProducts;
  String name;
  String imageUrl;
  double price;
  int amount;

  ProductsCart(
      this.idProducts, this.name, this.imageUrl, this.price, this.amount,
      {this.id = 0});
}
