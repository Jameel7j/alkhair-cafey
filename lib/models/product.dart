import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String? imageUrl;
  final double basePrice;
  final String categoryId;
  final Map<String, dynamic>? sizes; // e.g. {'صغير':0, 'كبير':5, 'قارورة':10} price delta

  Product({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.basePrice,
    required this.categoryId,
    this.sizes,
  });

  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['image'],
      basePrice: (data['basePrice'] ?? 0).toDouble(),
      categoryId: data['categoryId'] ?? '',
      sizes: data['sizes'] != null ? Map<String, dynamic>.from(data['sizes']) : null,
    );
  }
}
