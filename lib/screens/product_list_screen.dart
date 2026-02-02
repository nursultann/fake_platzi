import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];

              return ListTile(
                leading: Image.network(
                  product.images.isNotEmpty ? product.images[0] : '',
                  width: 50,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                ),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: product.id,
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
