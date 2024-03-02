import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dinnerdashbackend/blocs/category/category_bloc.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CategoryBloc _categoryBloc;
  StreamSubscription? _categorySubscription;

  ProductBloc({required CategoryBloc categoryBloc})
      : _categoryBloc = categoryBloc,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
    on<SortProducts>(_onSortProducts);
    on<AddProduct>(_onAddProduct);

    _categorySubscription = _categoryBloc.stream.listen((state) {
      if (state is CategoryLoaded && state.selectedCategory != null) {
        add(UpdateProducts(category: state.selectedCategory!));
      }
    });
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      print('Product added');
      emit(
        ProductLoaded(
          products: List.from((state as ProductLoaded).products)
            ..add(event.product),
        ),
      );
    }
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(ProductLoaded(products: event.products));
  }

  void _onUpdateProducts(
    UpdateProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future<void>.delayed(const Duration(seconds: 1));

    List<Product> filteredProducts = Product.products
        .where((product) => product.category == event.category.name)
        .toList();

    emit(ProductLoaded(products: filteredProducts));
  }

  void _onSortProducts(
    SortProducts event,
    Emitter<ProductState> emit,
  ) {}
}
