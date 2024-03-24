import 'package:dinnerdashbackend/blocs/product/product_bloc.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:dinnerdashbackend/widgets/custom_dropdown_button.dart';
import 'package:dinnerdashbackend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductCard extends StatelessWidget {
  const AddProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildNewProduct(context),
              );
            },
            iconSize: 40,
            icon: Icon(Icons.add_circle, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          Text(
            'Add a Product',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Dialog _buildNewProduct(BuildContext context) {
    Product product = const Product(
      name: '',
      restaurantId: 'LyXqruY9ud3ni3RtzJzf', //check this again later
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add a Product', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20.0),
              CustomDropdownButton(
                items: Category.categories.map((category) => category.name).toList(),
                onChanged: (value) {
                  // Update the product instance here
                  product = product.copyWith(category: value);
                },
              ),
              const SizedBox(height: 10.0),
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
                  product = product.copyWith(price: double.parse(value));
                },
              ),
              CustomTextFormField(
                maxLines: 1,
                title: 'Image URL',
                hasTitle: true,
                initialValue: '',
                onChanged: (value) {
                  product = product.copyWith(imageUrl: value);
          
                },
              ),
              CustomTextFormField(
                maxLines: 2,
                title: 'Description',
                hasTitle: true,
                initialValue: '',
                onChanged: (value) {
                  product = product.copyWith(description: value);
          
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context).add(
                      AddProduct(product: product),//call addProduct method from product_bloc.dart
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                  ),
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
////////////////////
/*return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 300, maxHeight: 600, minWidth:300, maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Add a Product', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 20.0),
                CustomDropdownButton(
                  items: Category.categories.map((category) => category.name).toList(),
                  onChanged: (value) {
                    // Update the product instance here
                    product = product.copyWith(category: value);
                  },
                ),
                const SizedBox(height: 10.0),
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
                    product = product.copyWith(price: double.parse(value));
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Image URL',
                  hasTitle: true,
                  initialValue: '',
                  onChanged: (value) {
                    product = product.copyWith(imageUrl: value);
            
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Description',
                  hasTitle: true,
                  initialValue: '',
                  onChanged: (value) {
                    product = product.copyWith(description: value);
            
                  },
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        AddProduct(product: product),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                    ),
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

