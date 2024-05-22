// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/models/category.dart';
import 'package:ecom_app/models/product-model.dart'; 

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('categories').get();

      List<Category> categories = [];
      for (var doc in querySnapshot.docs) {
        List<Product> products = await _getProductsForCategory(doc.id);
        categories.add(Category.fromFirestore(doc.data() as Map<String, dynamic>, doc.id, products));
      }

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<Product>> _getProductsForCategory(String categoryId) async {
    try {
      QuerySnapshot productSnapshot = await _firestore.collection('categories').doc(categoryId).collection('products').get();
      List<Product> products = productSnapshot.docs.map((doc) => Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
      return products;
    } catch (e) {
      print('Error fetching products for category $categoryId: $e');
      return [];
    }
  }
}
