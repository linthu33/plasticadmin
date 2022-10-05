import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/admin/bloc/product/products_bloc.dart';
import 'package:mystore/admin/models/ProductsModel.dart';
import 'package:mystore/admin/ui/product/editproduct.dart';
import 'package:mystore/admin/ui/product/productdetails.dart';

import '../../constants.dart';

class ProductListHome extends StatelessWidget {
  const ProductListHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ProductsLoadedState) {
        BlocProvider.of<ProductsBloc>(context).add(const Productloaded());
        List<ProductsModel> products = state.products;
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Constants.kPadding / 2,
                    right: Constants.kPadding / 2,
                    left: Constants.kPadding / 2),
                child: Card(
                  color: Constants.purpleLight,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ListTile(
                      //leading: Icon(Icons.sell),
                      title: const Text(
                        "Products Available",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Chip(
                        label: Text(
                          products.length.toString(),
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //BarChartSample2(),
              Padding(
                padding: const EdgeInsets.only(
                    top: Constants.kPadding,
                    left: Constants.kPadding / 2,
                    right: Constants.kPadding / 2,
                    bottom: Constants.kPadding),
                child: Card(
                  color: Constants.purpleLight,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _Product(products[index], context);
                      }),
                ),
              ),
            ],
          ),
        );
      }
      return const Center(
        child: Text('Something went wrong!'),
      );
    }));
  }
}

Padding _Product(ProductsModel product, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.color.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          product.title.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      ctx,
                      MaterialPageRoute(
                          builder: (context) => EditProduct(
                                prodedit: product,
                              )));
                },
                icon: const Icon(
                  Icons.add_task,
                  color: Colors.greenAccent,
                )),
            IconButton(
                onPressed: () {
                  ctx
                      .read<ProductsBloc>()
                      .add(ProductDelete(productid: product.Id.toString()));
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    ctx,
                    MaterialPageRoute(
                        builder: (context) => ProductListDetails(
                              products: product,
                            )),
                  );
                },
                icon: const Icon(
                  Icons.next_plan,
                  color: Colors.blueAccent,
                ))
          ],
        ),
      ],
    ),
  );
}
