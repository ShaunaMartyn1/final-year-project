import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/delivery_time_model.dart';
import 'package:flutter_app/models/voucher_model.dart';

import '../../models/models.dart';

part 'basket_event.dart';
part 'basket_state.dart';

/*class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading());
  
  @override
    Stream <BasketState> mapEventToState(
      BasketEvent event
      ) async* {
        if (event is StartBasket){
          yield* _mapStartBasketToState();
        }
        else if (event is AddItem){
          yield* _mapAddItemToState(event, state);

        }
        else if (event is RemoveItem){
          yield* _mapRemoveItemToState(event, state);

        }
        else if (event is RemoveAllItem){
          yield* _mapRemoveAllItemToState(event, state);

        }
        else if (event is ToggleSwitch){
          yield* _mapToggleSwitchToState(event, state);
        }
        else if (event is AddVoucher){
          yield* _mapAddVoucherToState(event, state);
        }
        else if (event is SelectDeliveryTime){
          yield* _mapSelectDeliveryTimeToState(event, state);
        }
    }

    Stream <BasketState> _mapStartBasketToState() async* {
      yield BasketLoading();
      try {
        await Future<void>.delayed(const Duration(seconds: 1));
        yield BasketLoaded(basket: Basket());
      } catch (_) {}
    }

    Stream <BasketState> _mapAddItemToState(
      AddItem event,
      BasketState state,
      
    ) async* {
      if  (state is BasketLoaded){
        try{ 
          yield BasketLoaded(
            basket: state.basket.copyWith(
              items: List.from(state.basket.items)..add(event.item),
            ),
          );
        }
        catch (_) {}
      }
    }

    Stream <BasketState> _mapRemoveItemToState(
      RemoveItem event,
      BasketState state,
      
    ) async* {
      if  (state is BasketLoaded){
        try{ 
          yield BasketLoaded(
            basket: state.basket.copyWith(
              items: List.from(state.basket.items)..remove(event.item),
            ),
          );
        }
        catch (_) {}
      }
    }

    Stream <BasketState> _mapRemoveAllItemToState(
      RemoveAllItem event,
      BasketState state,
      
    ) async* {
      if  (state is BasketLoaded){
        try{
          yield BasketLoaded(
            basket: state.basket.copyWith(
              items: List.from(state.basket.items)..removeWhere(
                (item) => item == event.item,
              ),
            ),
          );
        }
        catch (_) {}
      }
    }

    Stream <BasketState> _mapToggleSwitchToState(
      ToggleSwitch event,
      BasketState state,
      
    ) async* {
      if (state is BasketLoaded){
        try{
          yield BasketLoaded(
            basket: state.basket.copyWith(
              cutlery: !state.basket.cutlery,
            ),
          );
        }
        catch (_) {}
      }
    }

     Stream <BasketState> _mapAddVoucherToState(
      AddVoucher event,
      BasketState state,
      
    ) async* {
      if (state is BasketLoaded){
        try{
          yield BasketLoaded(
            basket: state.basket.copyWith(
              voucher: event.voucher,
            ),
          );
        }
        catch (_) {}
      }
    }
  }

  Stream <BasketState> _mapSelectDeliveryTimeToState(
      SelectDeliveryTime event,
      BasketState state,
      
    ) async* {
      if (state is BasketLoaded){
        try{
          yield BasketLoaded(
            basket: state.basket.copyWith(
              deliveryTime: event.deliveryTime,
            ),
          );
        }
        catch (_) {}
      }
    }
  
*/


class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading());

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is StartBasket) {
      yield* _mapStartBasketToState();
    } else if (event is AddItem) {
      yield* _mapAddItemToState(event, state);
    } else if (event is RemoveItem) {
      yield* _mapRemoveItemToState(event, state);
    } else if (event is RemoveAllItem) {
      yield* _mapRemoveAllItemToState(event, state);
    } else if (event is ToggleSwitch) {
      yield* _mapToggleSwitchToState(event, state);
    } else if (event is AddVoucher) {
      yield* _mapAddVoucherToState(event, state);
    } else if (event is SelectDeliveryTime) {
      yield* _mapSelectDeliveryTimeToState(event, state);
    }
  }

  Stream<BasketState> _mapStartBasketToState() async* {
    // Simulate fetching initial data or performing initial setup
    try {
      // Assuming fetching initial basket data might take time
      await Future<void>.delayed(const Duration(seconds: 1));
      yield BasketLoaded(basket: Basket());
    } catch (error) {
      yield BasketError("Failed to load basket.");
    }
  }
  //Add item to basket
  Stream<BasketState> _mapAddItemToState(AddItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            items: List.from(state.basket.items)..add(event.item),
          ),
        );
      } catch (_) {
        yield BasketError("Failed to add item.");
      }
    }
  }
  //Remove item from basket
  Stream<BasketState> _mapRemoveItemToState(RemoveItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            items: List.from(state.basket.items)..remove(event.item),
          ),
        );
      } catch (_) {
        yield BasketError("Failed to remove item.");
      }
    }
  }
  //Remove all items from basket
  Stream<BasketState> _mapRemoveAllItemToState(RemoveAllItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            items: List.from(state.basket.items)..removeWhere((item) => item == event.item),
          ),
        );
      } catch (_) {
        yield BasketError("Failed to remove all items.");
      }
    }
  }
  //Toggle switch for cutlery
  Stream<BasketState> _mapToggleSwitchToState(ToggleSwitch event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            cutlery: !state.basket.cutlery,
          ),
        );
      } catch (_) {
        yield BasketError("Failed to toggle switch.");
      }
    }
  }
  //Add Voucher
  Stream<BasketState> _mapAddVoucherToState(AddVoucher event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            voucher: event.voucher,
          ),
        );
      } catch (_) {
        yield BasketError("Failed to add voucher.");
      }
    }
  }
  //Delivery time
  Stream<BasketState> _mapSelectDeliveryTimeToState(SelectDeliveryTime event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            deliveryTime: event.deliveryTime,
          ),
        );
      } catch (_) {
        yield BasketError("Failed to select delivery time.");
      }
    }
  }
}

