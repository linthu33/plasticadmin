import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mystore/admin/models/ProductsModel.dart';
import 'package:mystore/admin/services/productrepository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;
  ProductsBloc({required this.productRepository}) : super(ProductsInitial()) {
    on<Productloaded>(_onLoadProduct);
    on<ProductAdd>(_onAddProduct);
    on<ProductUpdate>(_onUpdateProduct);
    on<ProductDelete>(_onDeleteProduct);
    on<ProductSearchEvent>(_onSearchProduct);
  }
  void _onLoadProduct(Productloaded event, Emitter<ProductsState> emit) async {
    final res = await productRepository.getProducts();
    emit(ProductsLoadedState(products: res));
  }

  void _onAddProduct(ProductAdd event, Emitter<ProductsState> emit) async {
    // print('-------------------');
    print(event.product.title);
    //print('-------------------');
    final state = this.state;
    final addproduct = await productRepository.AddProducts(event.product);
    // ignore: unrelated_type_equality_checks
    if (addproduct == 200) {
      if (state is ProductsLoadedState) {
        // print(state.products);
        emit(ProductsLoadedState(
            products: List.from(state.products)..add(event.product)));
      }
    } else {
      emit(ProductErrorState("errors"));
    }
  }

  void _onUpdateProduct(
      ProductUpdate event, Emitter<ProductsState> emit) async {
    //print();
    //print(ProductsModel.toJson());
    //print('-------------------');
    //print(event.product.toJson());
    //print('-------------------');
    final state = this.state;
    final editproduct = await productRepository.UpdateProducts(event.product);
    if (editproduct == 200) {
      if (state is ProductsLoadedState) {
        List<ProductsModel> update = (state.products.map((prod) {
          return prod.Id == event.product.Id ? event.product : prod;
        })).toList();
        //print(update);
        emit(ProductsLoadedState(products: update));
      }
    } else {
      emit(ProductErrorState("errors"));
    }
  }

  void _onDeleteProduct(
      ProductDelete event, Emitter<ProductsState> emit) async {
    final deleteproduct =
        await productRepository.DeleteProducts(event.productid);
    final state = this.state;
    if (deleteproduct == 200) {
      if (state is ProductsLoadedState) {
        List<ProductsModel> deleteproduct = state.products.where((product) {
          return product.Id != event.productid;
        }).toList();
        emit(ProductsLoadedState(products: deleteproduct));
      }
    } else {
      emit(ProductErrorState("errors"));
    }
  }

  void _onSearchProduct(
      ProductSearchEvent event, Emitter<ProductsState> emit) async {
    final searchproduct = 200;
    // await productRepository.DeleteProducts(event.productid);
    final state = this.state;
    if (searchproduct == 200) {
      if (state is ProductsLoadedState) {
        print(event.search);
        List<ProductsModel> searchproducts = state.products.where((product) {
          return product.title!.contains(event.search);
        }).toList();
        emit(ProductsLoadedState(products: searchproducts));
      }
    } else {
      emit(ProductErrorState("errors"));
    }
  }
}
