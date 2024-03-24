import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/delivery_time_model.dart';
import 'package:flutter_app/models/voucher_model.dart';

import '../../models/models.dart';

part 'basket_event.dart';
part 'basket_state.dart';


////////////////////////////////////////////////// 
/*
class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading());

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is StartBasket) {
      yield* _mapStartBasketToState();
    } else if (event is AddProduct) {
      yield* _mapAddProductToState(event, state);
    } else if (event is RemoveProduct) {
      yield* _mapRemoveProductToState(event, state);
    } else if (event is RemoveAllProduct) {
      yield* _mapRemoveAllProductToState(event, state);
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
  //Add Product to basket
  Stream<BasketState> _mapAddProductToState(AddProduct event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            products: List.from(state.basket.products)..add(event.product),
          ),
        );
      } catch (_) {
        yield BasketError("Failed to add Product.");
      }
    }
  }
  //Remove Product from basket
  Stream<BasketState> _mapRemoveProductToState(RemoveProduct event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            products: List.from(state.basket.products)..remove(event.product),
          ),
        );
      } catch (_) {
        yield BasketError("Failed to remove Product.");
      }
    }
  }
  //Remove all Products from basket
  Stream<BasketState> _mapRemoveAllProductToState(RemoveAllProduct event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            products: List.from(state.basket.products)..removeWhere((Product) => Product == event.product),
          ),
        );
      } catch (_) {
        yield BasketError("Failed to remove all Products.");
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
/////////////////////////////////////////////// has voucher code in it


class BasketBloc extends Bloc<BasketEvent, BasketState> {
  //final VoucherBloc _voucherBloc;
  //late StreamSubscription _voucherSubscription;

  BasketBloc({
    required VoucherBloc voucherBloc})
      :  _voucherBloc = voucherBloc,
        super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<RemoveAllProduct>(_onRemoveAllProduct);
    on<ToggleSwitch>(_onToggleSwitch);
    on<AddVoucher>(_onApplyVoucher);
    on<SelectDeliveryTime>(_onSelectDeliveryTime);

    /*_voucherSubscription = voucherBloc.stream.listen((state) {
      if (state is VoucherSelected)
        add(
          ApplyVoucher(state.voucher),
        );
    }*/
    );
  }

  void _onStartBasket(
    StartBasket event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: Basket()));
    } catch (_) {}
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..add(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveAllProduct(
    RemoveAllProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;

    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)
                ..removeWhere((product) => product == event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onToggleSwitch(
    ToggleSwitch event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      emit(
        BasketLoaded(
          basket: state.basket.copyWith(cutlery: !state.basket.cutlery),
        ),
      );
    }
  }

  void _onApplyVoucher(
    ApplyVoucher event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(voucher: event.voucher),
          ),
        );
      } catch (_) {}
    }
  }

  void _onSelectDeliveryTime(
    SelectDeliveryTime event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(deliveryTime: event.deliveryTime),
          ),
        );
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _voucherSubscription.cancel();
    return super.close();
  }
}
*/
class BasketBloc extends Bloc<BasketEvent, BasketState> {

  BasketBloc() : super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<RemoveAllProduct>(_onRemoveAllProduct);
    on<ToggleSwitch>(_onToggleSwitch);
    on<SelectDeliveryTime>(_onSelectDeliveryTime);
  }

  void _onStartBasket(
    StartBasket event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: Basket()));
    } catch (_) {}
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..add(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveAllProduct(
    RemoveAllProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;

    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)
                ..removeWhere((product) => product == event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onToggleSwitch(
    ToggleSwitch event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      emit(
        BasketLoaded(
          basket: state.basket.copyWith(cutlery: !state.basket.cutlery),
        ),
      );
    }
  }

  void _onSelectDeliveryTime(
    SelectDeliveryTime event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(deliveryTime: event.deliveryTime),
          ),
        );
      } catch (_) {}
    }
  }
}
