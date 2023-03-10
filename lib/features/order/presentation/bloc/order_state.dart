part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}


class LoadingOrdersState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedOrdersState extends OrderState {
  final List<Orderr> orders;

  const LoadedOrdersState(this.orders);
  @override
  List<Object> get props => [orders];
}

class ErrorOrdersState extends OrderState {
  final String errorMessage;

  const ErrorOrdersState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class LoadingCompleteOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedCompleteOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class ErrorCompleteOrderState extends OrderState {
  final String errorMessage;

  const ErrorCompleteOrderState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class LoadingReturnOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedReturnOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class ErrorReturnOrderState extends OrderState {
  final String errorMessage;

  const ErrorReturnOrderState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
