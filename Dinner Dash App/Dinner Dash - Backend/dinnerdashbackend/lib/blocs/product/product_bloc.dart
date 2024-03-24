import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dinnerdashbackend/blocs/category/category_bloc.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:dinnerdashbackend/models/product_model.dart';
import 'package:dinnerdashbackend/repos/restaurant/restaurant_repo.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final RestaurantRepo _restaurantRepo;
  final CategoryBloc _categoryBloc;
  StreamSubscription? _restaurantSubscription;
  StreamSubscription? _categorySubscription;

  ProductBloc({required CategoryBloc categoryBloc, 
  required RestaurantRepo restaurantRepo
  }) : _categoryBloc = categoryBloc,
        _restaurantRepo = restaurantRepo,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterProducts>(_onFilterProducts);
    on<SortProducts>(_onSortProducts);
    on<AddProduct>(_onAddProduct);

    _categorySubscription = _categoryBloc.stream.listen((state) {
      if (state is CategoryLoaded && state.selectedCategory != null) {
        add(
          FilterProducts(
            category: state.selectedCategory!)
          );
    }else {}
    });
    _restaurantSubscription = _restaurantRepo.getRestaurant().listen((restaurant) {
      add(
        LoadProducts(products: restaurant.products!),//only takes products from the restaurant object
      );
    });
  }

  //Adds a product to the list of products in firestore
  void _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      List<Product> newProducts = List.from((state as ProductLoaded).products)
        ..add(event.product);

        _restaurantRepo.editProducts(newProducts);
      emit(
        ProductLoaded(products: newProducts));
    }
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(ProductLoaded(products: event.products));
  }

  void _onFilterProducts(
    FilterProducts event,
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
  ) async {
    final state = this.state as ProductLoaded;
    emit(ProductLoading());
    await Future<void>.delayed(const Duration(seconds: 1));

    int newIndex = (event.newIndex > event.oldIndex) ? event.newIndex - 1 : event.newIndex;

    try {
      Product selectedProduct = state.products[event.oldIndex];
      List<Product> sortedProducts = List.from(state.products)
        ..remove(selectedProduct)
        ..insert(newIndex, selectedProduct);

      emit(ProductLoaded(products: sortedProducts));
    } catch (_) {}
  }

//Method that closes the streams
  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    _categorySubscription?.cancel();
    super.close();
  }
}
