import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('كافتيريا الخير'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('categories').orderBy('order').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final categories = snapshot.data!.docs;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return ListTile(
                leading: cat['image'] != null
                    ? Image.network(cat['image'], width: 60, height: 60, fit: BoxFit.cover)
                    : Icon(Icons.category),
                title: Text(cat['name']),
                subtitle: Text(cat['description'] ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProductListScreen(categoryId: cat.id, categoryName: cat['name'])),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  ProductListScreen({required this.categoryId, required this.categoryName});

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('products').where('categoryId', isEqualTo: categoryId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final products = snapshot.data!.docs.map((d) => Product.fromDoc(d)).toList();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) => ListTile(
              leading: products[i].imageUrl != null ? Image.network(products[i].imageUrl!, width: 60) : Icon(Icons.local_cafe),
              title: Text(products[i].name),
              subtitle: Text('${products[i].basePrice} ريال'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: products[i]))),
            ),
          );
        },
      ),
    );
  }
}
