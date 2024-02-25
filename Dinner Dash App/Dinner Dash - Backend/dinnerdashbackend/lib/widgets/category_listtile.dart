import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);
  
  final Category category;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(category.imageUrl,
      height: 25),
      title: Text(
          category.name,
          style: Theme.of(context)
          .textTheme
          .headlineSmall,
        ),
        subtitle: Text(
          category.description,
          style: Theme.of(context)
          .textTheme
          .headlineSmall,
        ),
        //trailing: const Icon(Icons.menu),
          );
  }
}

