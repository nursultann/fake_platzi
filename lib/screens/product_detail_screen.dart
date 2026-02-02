import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: FutureBuilder<Product>(
        future: ApiService.fetchProduct(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final product = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.images.isNotEmpty ? product.images[0] : '',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 100),
                ),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Text(product.description),
              ],
            ),
          );
        },
      ),
    );
  }
}
