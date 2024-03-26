import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:flutter_app/models/category_filter_model.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/models/price_filter_model.dart';
import 'package:flutter_app/models/restaurant_model.dart';

import '../../models/filter_model.dart';

part 'filters_event.dart';
part 'filters_state.dart';

/*class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersLoading());

  @override
  Stream<FiltersState> mapEventToState(
    FiltersEvent event,
  ) async* {
    if (event is FilterLoad) {
      yield* _mapFilterLoadToState();
    } else if (event is CategoryFilterUpdated) {
      yield* _mapCategoryFilterUpdatedToState(event, state);
    } else if (event is PriceFilterUpdated) {
      yield* _mapPriceFilterUpdatedToState(event, state);
    }
  }

  Stream<FiltersState> _mapFilterLoadToState() async* {
    yield FiltersLoaded(
      filter: Filter(
        categoryFilters: CategoryFilter.filters,
        priceFilters: PriceFilter.filters,
      ),
    );
  }

  Stream<FiltersState> _mapCategoryFilterUpdatedToState(
    CategoryFilterUpdated event,
    FiltersState state,
  ) async* {
    if (state is FiltersLoaded) {
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();

      yield FiltersLoaded(
        filter: Filter(
          categoryFilters: updatedCategoryFilters,
          priceFilters: state.filter.priceFilters,
        ),
      );
    }
  }

  Stream<FiltersState> _mapPriceFilterUpdatedToState(
    PriceFilterUpdated event,
    FiltersState state,
  ) async* {
    if (state is FiltersLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();

      yield FiltersLoaded(
          filter: Filter(
        categoryFilters: state.filter.categoryFilters,
        priceFilters: updatedPriceFilters,
      ));
    }
  }
}*/

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final RestaurantBloc _restaurantBloc;

  FiltersBloc({
    required RestaurantBloc restaurantBloc,
  })  : _restaurantBloc = restaurantBloc,
        super(FiltersLoading()) {
    on<LoadFilter>(_onLoadFilter);
    on<UpdateCategoryFilter>(_onUpdateCategoryFilter);
    on<UpdatePriceFilter>(_onUpdatePriceFilter);
  }

  void _onLoadFilter(
    LoadFilter event,
    Emitter<FiltersState> emit,
  ) {
    emit(FiltersLoaded(
      filter: Filter(
        categoryFilters: CategoryFilter.filters,
        priceFilters: PriceFilter.filters,
      ),
    ));
  }

  void _onUpdateCategoryFilter(
    UpdateCategoryFilter event,
    Emitter<FiltersState> emit,
  ) async {
    final state = this.state;
    if (state is FiltersLoaded) {
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();

      var categories = updatedCategoryFilters
          .where((filter) => filter.value)
          .map((filter) => filter.category)
          .toList();

      var prices = state.filter.priceFilters
          .where((filter) => filter.value)
          .map((filter) => filter.price.price)
          .toList();

      List<Restaurant> filteredRestaurants =
          _getFilteredRestaurants(categories, prices);

      emit(FiltersLoaded(
        filter: Filter(
          categoryFilters: updatedCategoryFilters,
          priceFilters: state.filter.priceFilters,
        ),
        filteredRestaurants: filteredRestaurants,
      ));
    }
  }

  void _onUpdatePriceFilter(
    UpdatePriceFilter event,
    Emitter<FiltersState> emit,
  ) async {
    final state = this.state;
    if (state is FiltersLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();

      var categories = state.filter.categoryFilters
          .where((filter) => filter.value)
          .map((filter) => filter.category)
          .toList();

      var prices = updatedPriceFilters
          .where((filter) => filter.value)
          .map((filter) => filter.price.price)
          .toList();

      List<Restaurant> filteredRestaurants =
          _getFilteredRestaurants(categories, prices);

      emit(FiltersLoaded(
        filter: Filter(
          categoryFilters: state.filter.categoryFilters,
          priceFilters: updatedPriceFilters,
        ),
        filteredRestaurants: filteredRestaurants,
      ));
    }
  }

  List<Restaurant> _getFilteredRestaurants(
      List<Category> categories, List<String> prices) {
    return (_restaurantBloc.state as RestaurantLoaded)
        .restaurants
        .where(
          (restaurant) => categories.any(
            (category) => restaurant.categories.contains(category),
          ),
        )
        .where(
          (restaurant) => prices.any(
            (price) => restaurant.priceCategory.contains(price),
          ),
        )
        .toList();
  }
}
