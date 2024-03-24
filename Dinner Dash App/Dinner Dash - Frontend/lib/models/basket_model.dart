/*import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/delivery_time_model.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/models/voucher_model.dart';

class Basket extends Equatable {
  final List<Product> products;
  final bool cutlery;
  final Voucher? voucher;
  final DeliveryTime? deliveryTime;

  Basket({
    this.products = const <Product>[],
    this.cutlery = false,
    this.voucher,
    this.deliveryTime,
  });

  Basket copyWith({
    List<Product>? products,
    bool? cutlery,
    Voucher? voucher,
    DeliveryTime? deliveryTime,
  }) {
    return Basket(
      products: products ?? this.products,
      cutlery: cutlery ?? this.cutlery,
      voucher: voucher ?? this.voucher,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  @override
  List<Object?> get props => [
    products,
    cutlery,
    voucher ?? 'NoVoucher' ,// Using a placeholder when voucher is null.
    deliveryTime,
  ];

  Map itemQuantity(products){
    var quantity = Map();

    products.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item.id] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
    products.fold(0, (total, current) => total + current.price);

    double total(subtotal){
      return  (voucher == null) ?
      subtotal + 5 : subtotal + 5 - voucher!.value; //get total with voucher price if voucher is not null
    }

    String get subtotalString => subtotal.toStringAsFixed(2);

    String get totalString => total(subtotal).toStringAsFixed(2);


}*/

////////////////////////////new basket model////////////////////////////

import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/delivery_time_model.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/models/voucher_model.dart';

class Basket extends Equatable {
  final List<Product> products;
  final bool cutlery;
  final Voucher? voucher;
  final DeliveryTime? deliveryTime;

  Basket({
    this.products = const <Product>[],
    this.cutlery = false,
    this.voucher,
    this.deliveryTime,
  });

  Basket copyWith({
    List<Product>? products,
    bool? cutlery,
    Voucher? voucher,
    DeliveryTime? deliveryTime,
  }) {
    return Basket(
      products: products ?? this.products,
      cutlery: cutlery ?? this.cutlery,
      voucher: voucher ?? this.voucher,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  @override
  List<Object?> get props => [
    products,
    cutlery,
    voucher ?? 'NoVoucher' ,// Using a placeholder when voucher is null.
    deliveryTime,
  ];

  Map itemQuantity(products){
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product.id] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
    products.fold(0, (total, current) => total + current.price);

    double total(subtotal){
      return  (voucher == null) ?
      subtotal + 5 : subtotal + 5 - voucher!.value; //get total with voucher price if voucher is not null
    }

    String get subtotalString => subtotal.toStringAsFixed(2);

    String get totalString => total(subtotal).toStringAsFixed(2);


}