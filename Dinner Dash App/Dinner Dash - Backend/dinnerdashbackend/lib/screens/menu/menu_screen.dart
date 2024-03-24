import 'package:dinnerdashbackend/blocs/blocs.dart';
import 'package:dinnerdashbackend/config/responsive.dart';
import 'package:dinnerdashbackend/widgets/custom_appbar.dart';
import 'package:dinnerdashbackend/widgets/custom_drawer.dart';
import 'package:dinnerdashbackend/widgets/product_card.dart';
import 'package:dinnerdashbackend/widgets/product_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/category_listtile.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  Widget _buildCategories(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber, // change this later
                  ),
                );
              } if (state is CategoryLoaded) {//else
                return ReorderableListView(
                  shrinkWrap: true,
                  children: [
                    for (int index = 0;
                        index < state.categories.length;
                        index++)
                      CategoryListTile(
                        category: state.categories[index],
                        onTap: () {
                          context
                              .read<CategoryBloc>()
                              .add(SelectCategory(state.categories[index]));//pass 1 category based on index in the list
                        },
                        key: ValueKey(state.categories[index].id),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    context.read<CategoryBloc>().add(
                        SortCategories(oldIndex: oldIndex, newIndex: newIndex));
                  },
                );
              } else {
                return Text('Error loading categories');
              }
            },
          ),
        ],
      ),
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
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber, // change this later
                ),
              );
            } else if (state is ProductLoaded) {
              return ReorderableListView(
                shrinkWrap: true,
                children: [
                  for (int index = 0; index < state.products.length; index++)
                    ProductListTile(
                      product: state.products[index],
                      onTap: () {
                        // action on tap
                      },
                      key: ValueKey(state.products[index].id),
                    ),
                ],
                onReorder: (oldIndex, newIndex) {
                  context.read<ProductBloc>().add(
                      SortProducts(oldIndex: oldIndex, newIndex: newIndex));
                },
              );
            } else {
              return Text('Error loading products');
            }
          },
        ),
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
                    _buildProductCarousel(),
                    const SizedBox(height: 20.0),
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 300, maxHeight: 1000),
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
          if (Responsive.isWideDesktop(context) ||
              Responsive.isDesktop(context))
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
                color: Theme.of(context).colorScheme.background,
                child: const Center(
                    child:
                        Text('Put something here, image or whatever')),
              ),
            ),
        ],
      ),
    );
  }

  BlocBuilder<ProductBloc, ProductState> _buildProductCarousel() {
    return BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors
                                .amber, // Replace with a valid constant color value
                          ),
                        );
                      }
                      if (state is ProductLoaded) {
                        return SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              return (index == 0) 
                              ? const AddProductCard()
                              : ProductCard(
                                product: state.products[index -1],
                                index: index,
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text('Error loading products');
                      }
                    },
                  );
  }
}
