import 'package:bloc/bloc.dart';
import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
   
      on<LoadCategories>(_onLoadCategories);
      on<SortCategories>(_onSortCategories);
      on<SelectCategory>(_onSelectCategory);
  }

  void _onLoadCategories(
    LoadCategories event, 
    Emitter<CategoryState> emit,
    )async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(CategoryLoaded(categories: event.categories)
      );
    }

  void _onSortCategories(
    SortCategories event,
    Emitter<CategoryState> emit,
    ) {
        final state = this.state as CategoryLoaded;
      }
    
  
  void _onSelectCategory(SelectCategory event, Emitter<CategoryState> emit,
  ){}
  
}
