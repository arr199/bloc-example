import 'package:bloc/bloc.dart';
import 'package:block/product/data/mock_products.dart';
import 'package:block/product/models/product.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(FetchingProducts()) {
    on<FetchProducts>(
      (event, emit) async {
        await Future.delayed(Duration(seconds: 2));
        // FETCHING THE PRODUCTS DATA AND CREATE THE PRODUCT STATE
        emit(ProductsLoaded(products: mockProducts));
      },
    );

    on<RemoveProduct>(
      (event, emit) {
        if (state is ProductsLoaded) {
          final currentState = state as ProductsLoaded;
          final newProducts = currentState.products
              .where((product) => product.id != event.id)
              .toList();

          emit(currentState.copyWith(newProducts: newProducts));
        }
      },
    );

    on<AddProduct>(
      (event, emit) {
        if (state is ProductsLoaded) {
          final currentState = state as ProductsLoaded;
          final newProducts = [...currentState.products];
          newProducts.add(event.product);

          emit(currentState.copyWith(newProducts: newProducts));
        }
      },
    );
  }
}
