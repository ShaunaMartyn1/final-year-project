part of 'basket_bloc.dart';

sealed class BasketState extends Equatable {
  const BasketState();
  
  
}

final class BasketLoading extends BasketState {

  @override
  List<Object> get props => [];
}

final class BasketLoaded extends BasketState {
  final Basket basket;

  BasketLoaded({required this.basket});

  @override
  List<Object> get props => [basket];
}


//////////////check this added to check if it works with errors in basket
class BasketError extends BasketState {
  final String error;
  const BasketError(this.error);

  @override
  List<Object> get props => [error];
}

