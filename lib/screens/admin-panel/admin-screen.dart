// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/models/category.dart'; 
import 'package:ecom_app/models/product-model.dart'; 
import 'package:ecom_app/screens/admin-panel/Widget/add-product-page.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return FutureBuilder<List<Category>>(
            future: _getCategoriesWithProducts(snapshot.data!.docs),
            builder: (context, categoriesSnapshot) {
              if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (categoriesSnapshot.hasError) {
                return Center(child: Text('Error: ${categoriesSnapshot.error}'));
              }

              return ListView.builder(
                itemCount: categoriesSnapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(categoriesSnapshot.data![index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProductPage(category: categoriesSnapshot.data![index])),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Category>> _getCategoriesWithProducts(List<QueryDocumentSnapshot> docs) async {
    List<Future<Category>> categoryFutures = docs.map((doc) async {
      List<Product> products = await _getProductsForCategory(doc.id);
      return Category.fromFirestore(
        doc.data() as Map<String, dynamic>, 
        doc.id,
        products,
      );
    }).toList();

    return Future.wait(categoryFutures);
  }

  Future<List<Product>> _getProductsForCategory(String categoryId) async {
    QuerySnapshot productSnapshot = await FirebaseFirestore.instance.collection('categories').doc(categoryId).collection('products').get();
    List<Product> products = productSnapshot.docs.map((doc) => Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
    return products;
  }
}
