part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class FetchingProducts extends ProductsState {
  

}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  List<Object> get props => [products];

  ProductsLoaded copyWith({newProducts}) {
    return ProductsLoaded(products: newProducts);
  }
}

final class ProductsError extends ProductsState {}
