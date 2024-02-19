import 'package:objectbox/objectbox.dart';

@Entity()
class Products {
  @Id()
  int id;

  int idProducts;
  String name;
  String imageUrl;
  double price;
  bool isSaved;

  Products(this.idProducts,this.name,this.imageUrl,this.price,{this.id = 0,this.isSaved = false});
}

