import 'package:flutter/material.dart';
import 'package:mystore/admin/models/orderproductModel.dart';

import 'package:mystore/admin/ui/enum.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.odlist}) : super(key: key);
  final Orderproduct? odlist;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late bool _activeshipping = true;
  late bool _activepaymnet = true;
  late bool _activeorder = true;
  late bool _activedelivery = true;
  late String dropdownvalue = 'All';
  String Oid = '';
  int totalamount = 0;
  int price = 0;
  int? quantity = 0;

  void initState() {
    Oid = widget.odlist!.Id.toString();
    /* totalamount = widget.odlist!.orderitem!
        .map((e) => e.totalamount)
        .fold(0, (previousValue, amount) => previousValue + amount!); */
    for (var element in widget.odlist!.orderitem!) {
      price = element.totalamount!;
      quantity = element.quantity!;
      totalamount += price * quantity!;
    }
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
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              /*  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WidgetTree())); */
            },
          ),
          // centerTitle: true,
          title: const Text('Order Details')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          //padding: EdgeInsets.symmetric(horizontal: 5),
          child: Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ExpansionPanelList(
                    elevation: 0,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        if (index == 0) {
                          _activeshipping = !_activeshipping;
                        } else if (index == 1) {
                          _activepaymnet = !_activepaymnet;
                        } else if (index == 2) {
                          _activedelivery = !_activedelivery;
                        } else {
                          _activeorder = !_activeorder;
                        }
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text('Shipping Address'),
                          );
                        },
                        body: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.odlist!.shippingaddress!.fullName
                                .toString()),
                            Text(widget.odlist!.shippingaddress!.country
                                .toString()),
                            Text(widget.odlist!.shippingaddress!.city
                                .toString()),
                            Text(widget.odlist!.shippingaddress!.address
                                .toString()),
                            Text(widget.odlist!.shippingaddress!.phone
                                .toString())
                          ],
                        ),
                        isExpanded: _activeshipping,
                      ),
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text(
                              'Payment Status',
                            ),
                          );
                        },
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.odlist!.paymentmethod.toString()),
                            Text(widget.odlist!.paymentstatus.toString()),
                          ],
                        ),
                        isExpanded: _activepaymnet,
                      ),
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text(
                              'Order List Status',
                            ),
                          );
                        },
                        body: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _createDataTable(widget.odlist!.orderitem!),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    const Spacer(flex: 6),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildText(
                                            title: 'Net total:',
                                            value: "",
                                            unite: true,
                                          ),
                                          const Divider(),
                                          buildText(
                                            title: 'Total amount :',
                                            titleStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            value: totalamount.toString(),
                                            unite: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        isExpanded: _activeorder,
                      ),
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text(
                              'Delevery status',
                            ),
                          );
                        },
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text(widget.odlist!.delivery!.title.toString()),
                            //Text(widget.odlist!.delivery!.price.toString()),
                            //Text(widget.odlist!.delivery!.estimateTime
                            //    .toString()),
                          ],
                        ),
                        isExpanded: _activedelivery,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DropdownButton(
                              value: dropdownvalue,
                              style: const TextStyle(height: 1.5),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: OrderStatus.values
                                  .map((OrderStatus classType) {
                                return DropdownMenuItem(
                                    value: classType.name.toString(),
                                    child: Text(classType.name.toString()));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownvalue = value.toString();
                                });
                              }),
                          ElevatedButton(
                              onPressed: () {
                                /*  BlocProvider.of<OrderBloc>(context).add(
                                    OrderStatusUpdateEvent(
                                        orderstatus: dropdownvalue.toString(),
                                        Id: Oid.toString())); */
                              },
                              child: const Text('Comfirm Status'))
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Text(title, style: style),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}

Card _orderlist(List<Orderitem> orderitem) {
  return Card(
    child: Scrollbar(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: orderitem.length,
          itemBuilder: (BuildContext context, index) {
            return _createDataTable(orderitem);
            /*   Container(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                leading: Text(index.toString(), style: TextStyle(fontSize: 18)),
                title: Text(
                  orderitem[index].quantity.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Text(orderitem[index].totalamount.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.purple)),
              ),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black26))),
            ); */
          }),
    ),
  );
}

DataTable _createDataTable(List<Orderitem> orderitem) {
  return DataTable(
      dividerThickness: 3,
      dataRowHeight: 80,
      showBottomBorder: true,
      headingTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      headingRowColor: MaterialStateProperty.resolveWith(
          (states) => const Color.fromARGB(255, 0, 0, 0)),
      columns: _createColumns(),
      rows: _createRows(orderitem));
}

List<DataColumn> _createColumns() {
  return [
    const DataColumn(label: Text('ID')),
    const DataColumn(label: Text('Orders')),
    const DataColumn(label: Text('Quantity')),
    const DataColumn(label: Text('Price')),
    const DataColumn(label: Text('TotalPrice')),
    //const DataColumn(label: Text('SubTotal')),
  ];
}

//data column နှင် row အရေတွက် မညီရင် error တက်ပါတယ်။ သတိထားပါ
List<DataRow> _createRows(List<Orderitem> orderitem) {
  int? count = 0;
  count = orderitem.length;

  return orderitem
      .map((item) => DataRow(cells: [
            DataCell(Text((count! == count ? count - 1 : count).toString())),
            DataCell(Text(item.producttype.toString())),
            DataCell(Text(item.quantity.toString())),
            DataCell(Text(item.totalamount.toString())),
            DataCell(Text(
                (item.quantity! * int.parse(item.totalamount.toString()))
                    .toString())),
          ]))
      .toList();
}
