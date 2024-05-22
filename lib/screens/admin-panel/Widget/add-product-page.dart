// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/models/category.dart'; 

class AddProductPage extends StatelessWidget {
  final Category category;

  const AddProductPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product to ${category.name}'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${category.name}'), 
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
              String productName = ''; 
              String description = ''; 
              double price = 0.0; 

              try {
                  await FirebaseFirestore.instance.collection('categories').doc(category.id).collection('products').add({
                    'name': productName,
                    'description': description,
                    'price': price,  
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
                  Navigator.pop(context); 
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add product: $e')));
              }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
