import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mystore/admin/models/orderproductModel.dart';

import '../../../services/productrepository.dart';
import '../../../ui/order/ordervocher.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final ProductRepository productRepository;
  OrderBloc({required this.productRepository}) : super(OrderInitial()) {
    on<Orderloaded>(_onLoadedOrder);
    on<OrderStatusUpdateEvent>(_onOrderStatusUpdate);
  }
  void _onLoadedOrder(Orderloaded event, Emitter<OrderState> emit) async {
    final res = await productRepository.GetOrder();
    emit(OrderLoadedState(orders: res));
  }

  void _onOrderStatusUpdate(
      OrderStatusUpdateEvent event, Emitter<OrderState> emit) async {
    try {
      const statuupdate = 200;
      //await productRepository.updateOrderStatus(event.orderstatus);
      final state = this.state;
      if (statuupdate == 200) {
        if (state is OrderLoadedState) {
          List<Orderproduct> statusupdate = (state.orders.map((order) {
            order.orderitem!.forEach((element) {
              if (element.oid == event.Id) {
                element.itemStatus = event.orderstatus;
              }
            });
            return order;
          })).toList();
          // print(statusupdate.forEach((element) {print(element.orderitem}));

          emit(OrderLoadedState(orders: statusupdate));
        }
      }
    } catch (err) {
      emit(OrderErrorState("order status update Error"));
    }
  }
}
