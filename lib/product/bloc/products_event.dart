part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductsEvent {}

class AddProduct extends ProductsEvent {
  final Product product;

  const AddProduct({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends ProductsEvent {
  final int id;
  const RemoveProduct({required this.id});

  @override
  List<Object> get props => [id];
}
