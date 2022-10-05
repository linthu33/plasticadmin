import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:mystore/admin/bloc/product/products_bloc.dart';
import 'package:mystore/admin/models/ProductsModel.dart';
import 'package:mystore/admin/ui/product/editproduct.dart';
import '../../constants.dart';

class ProductListDetails extends StatefulWidget {
  const ProductListDetails({Key? key, required this.products})
      : super(key: key);
  final ProductsModel products;

  @override
  State<ProductListDetails> createState() => _ProductListDetails();
}

class _ProductListDetails extends State<ProductListDetails> {
  late bool _activeshipping = false;
  late bool _activepriceone = false;
  late bool _activepricetwo = false;
  late bool _activedescription = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              /*  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WidgetTree()));*/
            },
          ),
          elevation: 1,
          title: const Text('Product Details',
              style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body:
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
                      //color: Constants.purpleLight,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: const ListTile(
                          //leading: Icon(Icons.sell),
                          title: Text(
                            "Products Available",
                            //style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "this  product is good quality.",
                            // style: TextStyle(color: Colors.white),
                          ),
                          trailing: Chip(
                            label: Text(
                              "20",
                              //style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //BarChartSample2(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        //color: Constants.purpleLight,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: _Product(widget.products, context)),
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

  Padding _Product(ProductsModel product, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          //mainAxisSize: MainAxisSize.min,

          children: [
            Expanded(
              flex: 4,
              child: const Text(
                "Title",
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                product.title.toString(),
                softWrap: true,
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.1,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: const Text(
                "color",
              ),
            ),
            Expanded(
              child: Text(
                product.color.toString(),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.1,
        ),
        Row(
          children: [
            Expanded(
              child: const Text(
                "certification",
              ),
            ),
            Expanded(
              child: Text(
                product.certification.toString(),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.1,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: const Text(
                "returnPolicy",
              ),
            ),
            Expanded(
              child: Text(
                product.returnPolicy.toString(),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.1,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: const Text(
                "brand",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                product.brand!.name.toString(),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.1,
        ),
        /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                if (index == 0) {
                  _activeshipping = !_activeshipping;
                }
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: Constants.purpleLight,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    textColor: Colors.amber,
                    title: Text('Shipping Address'),
                  );
                },
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.shipping!.dimensions!.depth.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      product.shipping!.dimensions!.width.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      product.shipping!.dimensions!.height.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    //Text(widget.odlist!.shippingaddress!.city.toString()),
                    //Text(widget.odlist!.shippingaddress!.address.toString()),
                    //Text(widget.odlist!.shippingaddress!.phone.toString())
                  ],
                ),
                isExpanded: _activeshipping,
              ),
            ],
          ),
        ),
         */
        ListView.builder(
            shrinkWrap: true,
            itemCount: product.description!.length,
            itemBuilder: (BuildContext context, int index) {
              return _description(product.description![index], context);
            }),
        ListView.builder(
            shrinkWrap: true,
            itemCount: product.pricetype!.length,
            itemBuilder: (BuildContext context, int index) {
              return _priceList(product.pricetype![index], context);
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          ],
        )
      ]),
    );
  }

  Padding _priceList(Pricetype pricetype, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            if (index == 0) {
              _activepriceone = !_activepriceone;
            } /*  else if (index == 1) {
              _activepriceone = !_activepriceone;
            } */
          });
        },
        children: [
          ExpansionPanel(
            //backgroundColor: Constants.purpleLight,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                textColor: Colors.amber,
                title: const Text("Price"),
                subtitle: Text(
                  pricetype.pricepackagename.toString(),
                ),
              );
            },
            body: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: const Text(
                        "Sell Price",
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        pricetype.sellprice.toString(),
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: const Text(
                        "Buy Price",
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        pricetype.buyprice.toString(),
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: const Text(
                        "Quantity",
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        pricetype.quantity.toString(),
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: const Text(
                        "In Date",
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        pricetype.indate.toString(),
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                //Text(product.shipping!.dimensions!.width.toString()),
                //Text(product.shipping!.dimensions!.height.toString()),
                //Text(widget.odlist!.shippingaddress!.city.toString()),
                //Text(widget.odlist!.shippingaddress!.address.toString()),
                //Text(widget.odlist!.shippingaddress!.phone.toString())
              ],
            ),
            isExpanded: _activepriceone,
          ),
        ],
      ),
    );
  }

  Padding _description(Description description, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            if (index == 0) {
              _activedescription = !_activedescription;
            } /*  else if (index == 1) {
              _activepriceone = !_activepriceone;
            } */
          });
        },
        children: [
          ExpansionPanel(
            //backgroundColor: Constants.purpleLight,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                  textColor: Colors.amber,
                  title: const Text("Description"),
                  subtitle: Text(description.lang.toString()),
                  trailing: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.amber,
                  ));
            },
            body: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: const Text(
                    "Description",
                    //style: const TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    description.details.toString(),
                    //style: const TextStyle(color: Colors.white),
                  ),
                ),
                //Text(product.shipping!.dimensions!.width.toString()),
                //Text(product.shipping!.dimensions!.height.toString()),
                //Text(widget.odlist!.shippingaddress!.city.toString()),
                //Text(widget.odlist!.shippingaddress!.address.toString()),
                //Text(widget.odlist!.shippingaddress!.phone.toString())
              ],
            ),
            isExpanded: _activedescription,
          ),
        ],
      ),
    );
  }
}
