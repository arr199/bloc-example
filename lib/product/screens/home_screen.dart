import 'dart:math';

import 'package:block/product/bloc/products_bloc.dart';
import 'package:block/product/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Product Screen"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (state is ProductsLoaded) {
                
                final price = (Random().nextDouble() * 100).roundToDouble();
                final id = Random().nextInt(5000) + 50;
                context.read<ProductsBloc>().add(AddProduct(
                    product:
                        Product(id: id, name: "New product", price: price)));
              }
            },
            child: const Text("Add"),
          ),
          body: Center(child: () {
            if (state is FetchingProducts) {
              return const CircularProgressIndicator();
            } else if (state is ProductsLoaded) {
              return const _ProductsView();
            } else {
              return const Text("Error Fetching Products");
            }
          }()),
        );
      },
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoaded) {
          final products = state.products;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  for (var i = 0; i < products.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(products[i].name,
                                      style: TextStyle(fontSize: 26)),
                                  const SizedBox(height: 2),
                                  Text(
                                    products[i].price.toString(),
                                    style: TextStyle(fontSize: 26),
                                  ),
                                ],
                              ),
                              IconButton.filledTonal(
                                  onPressed: () {
                                    context
                                        .read<ProductsBloc>()
                                        .add(RemoveProduct(id: products[i].id));
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                ],
              ),
            ),
          );
        } else {
          return const Text("Error fetching products");
        }
      },
    );
  }
}
