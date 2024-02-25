import 'package:dinnerdashbackend/blocs/category/category_bloc.dart';
import 'package:dinnerdashbackend/config/responsive.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:dinnerdashbackend/widgets/custom_appbar.dart';
import 'package:dinnerdashbackend/widgets/custom_drawer.dart';
import 'package:dinnerdashbackend/widgets/product_card.dart';
import 'package:dinnerdashbackend/widgets/product_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/category_listtile.dart';

/*class MenuScreen extends StatelessWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant Menu',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, //scroll horizontally
                        itemCount: Product.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            product: Product.products[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    //Responsive.isWideDesktop(context) || Responsive.isDesktop(context) ? - Causing error
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 300,
                        maxHeight: 1000,
                      ),
                      child: Row(children: [
                        Expanded(
                          child: BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              if (state is CategoryLoading){
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).colorScheme.primary,
                                    ),
                                  );
                              }
                              if (state is CategoryLoaded){

                              }
                              return Container(
                                padding: const EdgeInsets.all(20.0),
                                color: Theme.of(context).colorScheme.background,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Categories',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const SizedBox(height: 20.0),
                                    ...Category.categories.map((category) {
                                      return CategoryListTile(
                                        category: category,
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            } else {
                              return Text('Error');
                            }
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            color: Theme.of(context).colorScheme.background,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 20.0),
                                ...Product.products.map((product) {
                                  return ProductListTile(
                                    product: product,
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Responsive.isWideDesktop(context) || Responsive.isDesktop(context) ? - Causing error
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
              color: Theme.of(context).colorScheme.background,
              child: const Center(
                  child:
                      const Text('put somehing here image or ads or whatever')),
            ),
          )
        ],
      ),
    );
  }
}
*/



class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  BlocBuilder <CategoryBloc, CategoryState> _buildCategories(
    BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,//change this later
            ),
          );
        }
        else if (state is CategoryLoaded) {
          return ReorderableListView(
            shrinkWrap: true,
            children: [
              for (int index = 0; index < state.categories.length; index++,)
                CategoryListTile(category: state.categories[index], onTap: () {
                  //click to select category
                },
                key: ValueKey(state.categories[index].id),
                ),
            ],
            onReorder: (oldIndex, newIndex) {},
          );


          /*Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Categories', style: Theme.of(context).textTheme.headlineSmall
                ),
                const SizedBox(height: 20.0),
                ...state.categories.map((category) {
                  return CategoryListTile(category: category);
                }).toList(),
              ],
            ),
          );*/
        } else {
          return const Text('Error loading categories');
        }
      },
    );
  }

  Widget _buildProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20.0),
        ...Product.products.map((product) {
          return ProductListTile(product: product);
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant Menu',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Product.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            product: Product.products[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      constraints: const BoxConstraints(minHeight: 300, maxHeight: 1000),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              color: Theme.of(context).colorScheme.background,
                              child: _buildCategories(context),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              color: Theme.of(context).colorScheme.background,
                              child: _buildProducts(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (Responsive.isWideDesktop(context) || Responsive.isDesktop(context))
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
                color: Theme.of(context).colorScheme.background,
                child: const Center(child: Text('Put something here, image or ads or whatever')),
              ),
            ),
        ],
      ),
    );
  }
}
