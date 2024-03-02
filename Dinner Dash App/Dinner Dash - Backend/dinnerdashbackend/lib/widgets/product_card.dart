import 'package:dinnerdashbackend/blocs/product/product_bloc.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:dinnerdashbackend/widgets/custom_dropdown_button.dart';
import 'package:dinnerdashbackend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: (index == 0)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Product product = const Product(
                              name: '',
                              category: '',
                              description: '',
                              imageUrl: '',
                              price: 0,
                            );
                            return Dialog(
                              child: Container(
                                height: 450,
                                width: 500,
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text('Add a Product',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge),
                                    const SizedBox(height: 20.0),
                                    CustomDropdownButton(
                                      items: Category.categories
                                          .map((category) => category.name)
                                          .toList(),
                                      onChanged: (value) {
                                        product =
                                            product.copyWith(category: value);
                                        print(product); // to console
                                      },
                                    ),
                                    SizedBox(height: 10.0),
                                    CustomTextFormField(
                                      maxLines: 1,
                                      title: 'Name',
                                      hasTitle: true,
                                      initialValue: '',
                                      onChanged: (value) {
                                        product = product.copyWith(name: value);
                                      },
                                    ),
                                    CustomTextFormField(
                                      maxLines: 1,
                                      title: 'Price',
                                      hasTitle: true,
                                      initialValue: '',
                                      onChanged: (value) {
                                        product = product.copyWith(
                                            price: double.parse(value));
                                      },
                                    ),
                                    CustomTextFormField( //Need to do something with this - image upload maybe?
                                      maxLines: 1,
                                      title: 'Image URL',
                                      hasTitle: true,
                                      initialValue: '',
                                      onChanged: (value) {
                                        product =
                                            product.copyWith(imageUrl: value);
                                      },
                                    ),
                                    CustomTextFormField(
                                      maxLines: 3,
                                      title: 'Description',
                                      hasTitle: true,
                                      initialValue: '',
                                      onChanged: (value) {
                                        product = product.copyWith(
                                            description: value);
                                      },
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<ProductBloc>(context).add(
                                          AddProduct(product: product),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Save',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    iconSize: 40,
                    icon: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                Text(
                  'Add a Product',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(product.imageUrl),
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '\€${product.price}',
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
    );
  }
}
