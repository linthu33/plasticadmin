import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/admin/bloc/order/bloc/order_bloc.dart';
import 'package:mystore/admin/bloc/product/products_bloc.dart';
import 'package:mystore/admin/models/ProductsModel.dart';

import 'package:mystore/admin/ui/product/productdetails.dart';

class ProductHome extends StatefulWidget {
  const ProductHome({
    Key? key,
  }) : super(key: key);

  @override
  _ProductHome createState() => _ProductHome();
}

class _ProductHome extends State<ProductHome> {
  late TextEditingController search = TextEditingController();
  late int stockbalance; //စတိုလက်ကျန်
  late int sellquantity;
  late int instock;
  late int stockprice = 0;
  late int sellprice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stockbalance = 0;
    sellquantity = 0;
    instock = 0;
  }

  @override
  Widget build(BuildContext context) {
    final blocorder = BlocProvider.of<ProductsBloc>(context);

    return Scaffold(body:
        BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ProductsLoadedState) {
        stockbalance = 0;
        stockprice = 0;
        List<ProductsModel> products = state.products;
        var dd = state.products.forEach((element) {
          for (var price in element.pricetype!) {
            stockbalance += price.quantity!;
            stockprice += price.buyprice!;
          }
        });
        MyData allproduct = MyData(products, context);
        return SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                if (state is OrderLoadedState) {
                  sellquantity = 0;
                  sellprice = 0;
                  var filterorder =
                      state.orders.where((e) => e.orderstatus == "true");
                  var itemslist = filterorder.forEach((element) {
                    for (var b in element.orderitem!) {
                      if (b.itemStatus != "Completed") {
                        sellquantity += b.quantity!;
                        sellprice += b.sellprice!;
                      }
                    }
                  });
                }
                return Container(
                  child: Text(''),
                );
              }),
              /*   Column(
                children: [
                  //ရှိရင်းငွေ
                  /*   Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('')),
                      ),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "စတိုရှိရင်းတန်ဖိုး" + "=" + stockprice.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "စတိုလက်ကျန်တန်ဖိုး" +
                              "=" +
                              (stockprice - sellprice).toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "စတိုအရောင်းတန်ဖိုး" + "=" + sellprice.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "Product Available" +
                              ":" +
                              products.length.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ],
                  ), */
                  //အရေတွက်
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: search,
                            onChanged: ((value) {
                              if (value.isNotEmpty) {
                                blocorder
                                    .add(ProductSearchEvent(search: value));
                              } else {
                                blocorder.add(const Productloaded());
                              }
                            }),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Enter a search product',
                              //border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: search.clear,
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "စတိုရှိရင်း" + "=" + stockbalance.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "စတိုလက်ကျန်" +
                              "=" +
                              (stockbalance - sellquantity).toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "စတိုအရောင်း" + "=" + sellquantity.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Chip(
                        backgroundColor: Colors.black,
                        label: Text(
                          "Product Available" +
                              ":" +
                              products.length.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ],
                  ),
                ],
              ), */
              PaginatedDataTable(
                source: allproduct,
                header: const Text('My Products'),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('title')),
                  DataColumn(label: Text('images')),
                  DataColumn(label: Text('color')),
                  DataColumn(label: Text('reviewPoint')),
                  DataColumn(label: Text('certification')),
                  DataColumn(label: Text('returnPolicy')),
                  DataColumn(label: Text('sublabel')),
                  DataColumn(label: Text('price')),
                ],
                arrowHeadColor: Colors.blueAccent,
                columnSpacing: 100,
                horizontalMargin: 10,
                rowsPerPage: 8,
                showCheckboxColumn: false,
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

// The "soruce" of the table
class MyData extends DataTableSource {
  // Generate some made-up data
  late List<ProductsModel> _data;
  BuildContext context;
  MyData(this._data, this.context);
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(_data[index].title.toString())),
      DataCell(Image.network(
        "http://localhost:5000/uploads/1.jpg",
        width: 100,
        height: 100,
      )),
      DataCell(Text(_data[index].color.toString())),
      DataCell(Text(_data[index].brand!.name.toString())),
      DataCell(Text(_data[index].reviewPoint.toString())),
      DataCell(Text(_data[index].certification.toString())),
      DataCell(Text(_data[index].returnPolicy.toString())),
      DataCell(Center(
        child: ElevatedButton(
          child: const Text("deatils=>"),
          onPressed: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductListDetails(products: _data[index])));
          },
        ),
      )),
    ]);
  }
}
