import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = '';
  int qty = 1;

  @override
  void initState() {
    super.initState();
    if (widget.product.sizes != null && widget.product.sizes!.isNotEmpty) {
      selectedSize = widget.product.sizes!.keys.first;
    }
  }

  double get price {
    double delta = 0;
    if (widget.product.sizes != null && widget.product.sizes![selectedSize] != null) {
      delta = (widget.product.sizes![selectedSize] as num).toDouble();
    }
    return widget.product.basePrice + delta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.product.imageUrl != null) Image.network(widget.product.imageUrl!),
            SizedBox(height: 12),
            Text(widget.product.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (widget.product.sizes != null)
              Wrap(
                spacing: 8,
                children: widget.product.sizes!.keys.map((s) {
                  return ChoiceChip(
                    label: Text(s),
                    selected: selectedSize == s,
                    onSelected: (_) => setState(() => selectedSize = s),
                  );
                }).toList(),
              ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('السعر: ${price.toStringAsFixed(2)} ريال', style: TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: () {
                    // إضافة إلى السلة - سيتم تنفيذ لاحقًا
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('أضيف إلى السلة')));
                  },
                  child: Text('أضف إلى السلة'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
