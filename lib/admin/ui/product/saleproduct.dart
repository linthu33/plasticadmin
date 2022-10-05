import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/admin/bloc/order/bloc/order_bloc.dart';
import 'package:mystore/admin/models/orderproductModel.dart';

import '../../constants.dart';
import '../order/ordervocher.dart';

class SaleProduct extends StatefulWidget {
  const SaleProduct({Key? key}) : super(key: key);

  @override
  _SaleHomeState createState() => _SaleHomeState();
}

class _SaleHomeState extends State<SaleProduct> {
  late int totalsum = 0;
  void initState() {
    /* totalamount = widget.odlist!.orderitem!
        .map((e) => e.totalamount)
        .fold(0, (previousValue, amount) => previousValue + amount!); */

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    // do not forget to close, prefer use BlocProvider - it would handle it for you
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is OrderLoadedState) {
        //BlocProvider.of<OrderBloc>(context).add(const Productloaded());
        var filterproduct =
            state.orders.where((e) => e.paymentstatus == "true");
        List<Orderproduct>? products = List.from(filterproduct);
        var itemslist = filterproduct.forEach((element) {
          for (var b in element.orderitem!) {
            if (b.itemStatus == "Complted") {
              totalsum += b.totalamount!;
            }
          }
        });

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
                          "Sale",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: const Text(
                          "ရောင်းရငွေ",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Chip(
                          label: Text(
                            totalsum.toString(),
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
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
                        return _ProductList(products[index], context);
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

Padding _ProductList(Orderproduct product, BuildContext ctx) {
  final ord = product.orderitem!.map(((e) => e.totalamount));
  var sumdata = ord.reduce((a, b) => a! + b!);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        product.barcode.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      Text(
        product.orderstatus.toString(),
        style: const TextStyle(color: Colors.cyan),
      ),
      Text(
        sumdata.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              ctx,
              MaterialPageRoute(
                  builder: (context) => VoucherScreen(
                        invoice: product,
                      )),
            );
          },
          child: Wrap(
            children: const [
              Icon(
                Icons.shop,
                color: Colors.deepOrange,
                size: 24.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text("details!", style: TextStyle(fontSize: 16)),
            ],
          ))
    ]),
  );
}
