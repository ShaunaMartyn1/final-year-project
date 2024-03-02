part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct({required this.product});

  @override
  List<Object> get props => [product];
}

class LoadProducts extends ProductEvent {
  final List<Product> products;

  const LoadProducts({this.products = const <Product>[]});

  @override
  List<Object> get props => [products];
}

class UpdateProducts extends ProductEvent {
  final Category category;

  const UpdateProducts({required this.category});

  @override
  List<Object> get props => [category];
}

class SortProducts extends ProductEvent {
  final int oldIndex;
  final int newIndex;

  const SortProducts({required this.oldIndex, required this.newIndex});

  @override
  List<Object> get props => [oldIndex, newIndex];
}
