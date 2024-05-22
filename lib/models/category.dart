import 'package:ecom_app/models/product-model.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final List<Product> products;

  Category({
    required this.id,
    required this.name,
     required this.imageUrl,
    required this.products,
  });

  factory Category.fromFirestore(Map<String, dynamic> data, String id, List<Product> products) {
    return Category(
      id: id,
      name: data['name'],
      imageUrl: data['imageUrl'],
      products: products,
    );
  }
}
