import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);
  
  final Product product;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(
          product.name,
          style: Theme.of(context)
          .textTheme
          .headlineSmall,
        ),
        subtitle: Text(
          product.description,
          style: Theme.of(context)
          .textTheme
          .headlineSmall,
        ),
        trailing: const Icon(Icons.menu),
          );
  }
}

